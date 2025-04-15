module Niivue

using Bonito

export niivue, use_electron_display

function niivue()
    obs = Observable(["setCrosshairWidth", 5])

    nv_dom = DOM.canvas(id="gl"; width=400, height=400)

    js_eval = js"""
        import("https://cdn.jsdelivr.net/npm/@niivue/niivue@0.56.0/+esm").then((Niivue) => {
            const nv = new Niivue.Niivue()
            nv.attachTo('gl')
            function nv_call(args) {
                const [method, arg] = args[0]
                console.log("niivue call", method, arg)
                nv[method](arg)
            }
            Bonito.onany([$(obs)], nv_call)
        })
    """

    app = App() do session
        obs2 = Observable(["setCrosshairWidth", 5])
        DOM.div(nv_dom, evaljs(session, js_eval))
    end
    return NiivueViewer(app, obs)
end

struct NiivueViewer
    app::App
    obs::Observable
end

# Overload the call operator to allow calling nv("setCrosshairWidth", 5)
function (nv::NiivueViewer)(method::String, arg)
    nv.obs[] = [method, arg]
end

# Overload dot syntax for e.g. nv.setCrosshairWidth(5)
function Base.getproperty(nv::NiivueViewer, name::Symbol)
    if hasfield(typeof(nv), name)
        return getfield(nv, name)
    else
        return value -> nv(string(name), value)
    end
end

end
