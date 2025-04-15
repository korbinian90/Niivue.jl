module Niivue

using Bonito

export niivue, use_electron_display

function niivue(; width=400, height=400)
    methods = Observable(["setCrosshairWidth", 5])
    opts = Observable(["isColorbar", false])

    nv_dom = DOM.canvas(id="gl"; width, height)

    js_eval = js"""
        import("https://cdn.jsdelivr.net/npm/@niivue/niivue@0.56.0/+esm").then((Niivue) => {
            const nv = new Niivue.Niivue()
            nv.attachTo('gl')
            function nv_method(args) {
                const [method, arg] = args[0]
                console.log("niivue call", method, arg)
                nv[method](arg)
            }
            function nv_opts(args) {
                const [method, arg] = args[0]
                console.log("niivue property", method, arg)
                nv.opts[method] = arg
                nv.updateGLVolume()
            }
            Bonito.onany([$methods], nv_method)
            Bonito.onany([$opts], nv_opts)
        })
    """

    app = App() do session
        DOM.div(nv_dom, evaljs(session, js_eval))
    end
    return NiivueViewer(app, methods, opts)
end

struct NiivueViewer
    app::App
    methods::Observable
    opts::Observable
end

# Overload the call operator to allow calling nv("setCrosshairWidth", 5)
function (nv::NiivueViewer)(method::String, arg)
    nv.methods[] = [method, arg]
end

# Overload dot syntax for e.g. nv.setCrosshairWidth(5)
function Base.getproperty(nv::NiivueViewer, name::Symbol)
    if hasfield(typeof(nv), name)
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

end
