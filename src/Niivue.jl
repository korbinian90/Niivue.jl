module Niivue

using Bonito, NIfTI
import Observables

export niivue

function niivue(volumes=[]; width=400, height=400, opts=Tuple[], methods=Tuple[], meshes=[], ni_args...)
    if !isempty(volumes)
        volumes = resolve_volumes(volumes; ni_args...)
        methods = vcat(methods, ("loadVolumes", volumes))
    end
    if !isempty(meshes)
        meshes = resolve_meshes(meshes)
        methods = vcat(methods, ("loadMeshes", meshes))
    end
    
    obs_methods = Observable(["setCrosshairWidth", 5])
    obs_opts = Observable(["isColorbar", false])
    obs_events = Observable{Any}(Dict{String, Any}())
    callbacks = Dict{String, Vector{Any}}()

    # Dispatch events from JS to registered Julia callbacks
    Observables.on(obs_events) do val
        name = get(val, "event", "")
        for cb in get(callbacks, name, Any[])
            cb(val)
        end
    end

    nv_dom = DOM.canvas(id="gl"; width, height)

    js_eval = js"""
        import("https://cdn.jsdelivr.net/npm/@niivue/niivue@0.56.0/+esm").then((Niivue) => {
            const nv = new Niivue.Niivue()
            window.nv = nv
            nv.attachTo('gl')
            function fix_volumes(volumes) {
                for (const volume of volumes) {
                    if (volume.url instanceof Uint8Array) {
                        volume.url = volume.url.slice()
                    }
                }
            }
            function nv_methods(args) {
                for (const [method, arg] of args) {
                    console.log("niivue method", method, arg)
                    if (method === "loadVolumes") {
                        fix_volumes(arg)
                        nv.loadVolumes(arg)
                    } else if (method === "loadMeshes") {
                        nv.loadMeshes(arg)
                    } else {
                        nv[method](arg)
                    }
                }
            }
            function nv_opts(args) {
                for (const [method, arg] of args) {
                    console.log("niivue property", method, arg)
                    nv.opts[method] = arg
                }
                nv.updateGLVolume()
            }
            nv_opts($opts)
            nv_methods($methods)
            nv.updateGLVolume()
            Bonito.onany([$obs_methods], nv_methods)
            Bonito.onany([$obs_opts], nv_opts)

            // Bidirectional: JS events → Julia via Observable
            nv.onLocationChange = (data) => {
                $obs_events.notify({event: "location_change", string: data.string || ""})
            }
            nv.onDragRelease = (data) => {
                $obs_events.notify({
                    event: "drag_release",
                    tile_idx: data.tileIdx != null ? data.tileIdx : null,
                    ax_cor_sag: data.axCorSag != null ? data.axCorSag : null,
                    mm_length: data.mmLength || 0,
                    vox_start: data.voxStart || [0,0,0],
                    vox_end: data.voxEnd || [0,0,0]
                })
            }
            nv.onImageLoaded = () => {
                $obs_events.notify({event: "image_loaded"})
            }
            nv.onFrameChange = (volume, idx) => {
                $obs_events.notify({event: "frame_change", frame: idx})
            }
            nv.onClipPlaneChange = (cp) => {
                $obs_events.notify({event: "clip_plane_change", clip_plane: Array.from(cp)})
            }
            nv.onIntensityChange = (data) => {
                $obs_events.notify({event: "intensity_change", string: data.string || ""})
            }
            nv.onVolumeUpdated = () => {
                $obs_events.notify({event: "volume_updated"})
            }
        })
    """

    app = App() do session
        DOM.div(nv_dom, evaljs(session, js_eval))
    end
    return NiivueViewer(app, obs_methods, obs_opts, obs_events, callbacks)
end

struct NiivueViewer
    app::App
    methods::Observable
    opts::Observable
    events::Observable{Any}
    callbacks::Dict{String, Vector{Any}}
end

"""
    on(callback, nv::NiivueViewer, event::Symbol)

Register a Julia callback for a NiiVue event. Available events:
`:location_change`, `:drag_release`, `:image_loaded`, `:frame_change`,
`:clip_plane_change`, `:intensity_change`, `:volume_updated`.

# Example
```julia
nv = niivue("https://niivue.github.io/niivue-demo-images/mni152.nii.gz")
on(nv, :location_change) do data
    println("Crosshair: ", data["string"])
end
```
"""
function Observables.on(f::Function, nv::NiivueViewer, event::Symbol)
    name = string(event)
    if !haskey(nv.callbacks, name)
        nv.callbacks[name] = Any[]
    end
    push!(nv.callbacks[name], f)
    return nothing
end

function resolve_volumes(volumes; ni_args...)
    if !(volumes isa AbstractVector)
        volumes = [volumes]
    end
    volumes = [(!(v isa Dict) ? Dict{Symbol, Any}(:url => v) : v) for v in volumes]
    volumes = [Dict{Symbol, Any}(k => v for (k, v) in d) for d in volumes]

    for v in volumes
        if is_local_file(v[:url])
            if !haskey(v, :name)
                v[:name] = v[:url]
            end
            v[:url] = read(v[:url])
        elseif v[:url] isa AbstractArray && ndims(v[:url]) > 1
            if !haskey(v, :name)
                v[:name] = "Image.nii"
            end
            buf = IOBuffer()
            write(buf, NIVolume(v[:url]; ni_args...))
            v[:url] = buf.data
        end
    end
    return volumes
end

function resolve_meshes(meshes)
    if !(meshes isa AbstractVector)
        meshes = [meshes]
    end
    meshes = [(!(m isa Dict) ? Dict{Symbol, Any}(:url => m) : m) for m in meshes]
    return [Dict{Symbol, Any}(k => v for (k, v) in d) for d in meshes]
end

function is_local_file(url)
    return url isa String && !startswith(url, "http")
end

function (nv::NiivueViewer)(method::String, arg)
    nv.methods[] = [method, arg]
end

function Base.getproperty(nv::NiivueViewer, name::Symbol)
    if name == :loadVolumes
        return vols -> nv.methods[] = ["loadVolumes", resolve_volumes(vols)]
    elseif name == :loadMeshes
        return meshes -> nv.methods[] = ["loadMeshes", resolve_meshes(meshes)]
    elseif hasfield(typeof(nv), name)
        return getfield(nv, name)
    else
        return value -> nv.methods[] = [string(name), value]
    end
end

function Base.setproperty!(nv::NiivueViewer, name::Symbol, value)
    if hasfield(typeof(nv), name)
        setfield!(nv, name, value)
    else
        nv.opts[] = [string(name), value]
    end
end

Base.display(nv::Niivue.NiivueViewer) = Base.display(nv.app)
Base.show(io::IO, m::MIME"text/html", nv::Niivue.NiivueViewer) = Base.show(io, m, nv.app)

end
