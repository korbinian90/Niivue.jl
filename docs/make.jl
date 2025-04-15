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
    ],
)

deploydocs(;
    repo="github.com/korbinian90/Niivue.jl",
    devbranch="main",
)
