## Installation
# import Pkg; Pkg.add(url="https://github.com/korbinian90/Niivue.jl")

## Usage
using Niivue

volumes = [
    Dict(
        :url => "https://niivue.github.io/niivue/images/mni152.nii.gz",
        :colormap => "gray",
    ),
    Dict(
        :url => "https://niivue.github.io/niivue/images/hippo.nii.gz",
        :colormap => "red",
    )
]

opts = [("isColorbar", true)]
methods = [("setCrosshairWidth", 10)]

# in vscode: opens plot pane by default (to open in browser: ctr+shift+p -> deactivate plot pane)
# in REPL: opens browser by default
nv1 = niivue(volumes; opts, methods)

nv1.setCrosshairWidth(10)
nv1.isColorbar = false

## Use Electron display instead
# in vscode: ctr+shift+p -> deactivate plot pane
using Electron
use_electron_display(devtools=true)
