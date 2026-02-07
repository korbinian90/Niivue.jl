using Niivue
using Documenter

DocMeta.setdocmeta!(Niivue, :DocTestSetup, :(using Niivue); recursive=true)

makedocs(;
    modules=[Niivue],
    authors="Korbinian Eckstein korbinian90@gmail.com",
    sitename="Niivue.jl",
    format=Documenter.HTML(;
        canonical="https://korbinian90.github.io/Niivue.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Example Gallery" => "gallery.md",
        "Examples" => "examples.md",
        "Julia-Specific Features" => "julia_features.md",
        "API Reference" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/korbinian90/Niivue.jl",
    devbranch="main",
)
