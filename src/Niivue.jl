module Niivue

using Bonito, NIfTI

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
        })
    """

    app = App() do session
        DOM.div(nv_dom, evaljs(session, js_eval))
    end
    return NiivueViewer(app, obs_methods, obs_opts)
end

struct NiivueViewer
    app::App
    methods::Observable
    opts::Observable
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
