module Niivue

using Bonito, NIfTI

export niivue

"""
    niivue(volumes=[]; width=400, height=400, opts=Tuple[], methods=Tuple[], ni_args...)

Create an interactive NiiVue viewer for neuroimaging data.

# Arguments
- `volumes`: Volume(s) to display. Can be:
  - A 3D/4D array (automatically converted to NIfTI)
  - A single URL string or file path
  - A Dict with volume options (`:url`, `:colormap`, `:opacity`, etc.)
  - A Vector of URLs/Dicts for multiple volumes
- `width::Int=400`: Canvas width in pixels
- `height::Int=400`: Canvas height in pixels
- `opts::Tuple=Tuple[]`: Initial options as tuple pairs, e.g. `[("isColorbar", true)]`
- `methods::Tuple=Tuple[]`: Initial methods to call as tuple pairs, e.g. `[("setCrosshairWidth", 5)]`
- `ni_args...`: Additional arguments for NIfTI conversion (e.g., `voxel_size=(1,1,1)`)

# Returns
- `NiivueViewer`: An interactive viewer object

# Examples
```julia
# Display a random array
nv = niivue(rand(50, 50, 20))

# Load from URL
nv = niivue("https://niivue.github.io/niivue-demo-images/mni152.nii.gz")

# Multiple volumes with options
volumes = [
    Dict(:url => "mni152.nii.gz", :colormap => "gray"),
    Dict(:url => "overlay.nii.gz", :colormap => "red", :opacity => 0.5)
]
nv = niivue(volumes)

# With initial settings
nv = niivue(
    volumes,
    opts = [("isColorbar", true), ("backColor", [1, 1, 1, 1])],
    methods = [("setCrosshairWidth", 5)]
)
```

# Interactive Usage
After creating a viewer, you can modify it interactively:

```julia
# Call methods
nv.setCrosshairWidth(10)
nv.setCrosshairColor([0, 1, 1, 0.5])

# Set options
nv.isColorbar = true
nv.backColor = [0.3, 0.3, 0.3, 1]

# Load new volumes
nv.loadVolumes([Dict(:url => "new_volume.nii.gz")])
```

See the [NiiVue documentation](https://niivue.com/docs/) for all available methods and options.
"""
function niivue(volumes=[]; width=400, height=400, opts=Tuple[], methods=Tuple[], ni_args...)
    if !isempty(volumes)
        volumes = resolve_volumes(volumes; ni_args...)
        methods = vcat(methods, ("loadVolumes", volumes))
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
    # convert strings to Dict{Symbol, Any}(:url => v)
    volumes = [(!(v isa Dict) ? Dict{Symbol, Any}(:url => v) : v) for v in volumes]

    # convert to Dict{Symbol, Any}
    volumes = [Dict{Symbol, Any}(k => v for (k, v) in d) for d in volumes]

    for v in volumes
        if is_local_file(v[:url]) # read local files
            if !haskey(v, :name)
                v[:name] = v[:url]
            end
            v[:url] = read(v[:url])
        elseif v[:url] isa AbstractArray && ndims(v[:url]) > 1 # convert array to NIfTI
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

function is_local_file(url)
    return url isa String && !startswith(url, "http")
end

# Overload the call operator to allow calling nv("setCrosshairWidth", 5)
function (nv::NiivueViewer)(method::String, arg)
    nv.methods[] = [method, arg]
end

# Overload dot syntax for e.g. nv.setCrosshairWidth(5)
function Base.getproperty(nv::NiivueViewer, name::Symbol)
    if name == :loadVolumes
        return vols -> nv.methods[] = ["loadVolumes", resolve_volumes(vols)]
    elseif hasfield(typeof(nv), name)
        return getfield(nv, name)
    else
        return value -> nv.methods[] = [string(name), value]
    end
end

# Overload dot syntax for e.g. nv.isColorbar = true
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
