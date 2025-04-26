module Niivue

using Bonito

export niivue, use_electron_display

function niivue(volumes=[]; width=400, height=400, opts=Tuple[], methods=Tuple[])
    if !isempty(volumes)
        volumes = resolve_volumes(volumes)
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

function resolve_volumes(volumes)
    # convert to Dict{Symbol, Any}
    volumes = [Dict{Symbol, Any}(k => v for (k, v) in d) for d in volumes]
    # read local files
    for v in volumes
        if is_local_file(v[:url])
            if !haskey(v, :name)
                v[:name] = v[:url]
            end
            v[:url] = read(v[:url])
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

end
