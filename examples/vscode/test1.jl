## Installation
# import Pkg; Pkg.add(url="https://github.com/korbinian90/Niivue.jl")

## Usage
using Niivue

volumes = [
    Dict(
        :url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
        :colormap => "gray",
    ),
    Dict(
        :url => "https://niivue.github.io/niivue-demo-images/spmMotor.nii.gz",
        :colormap => "redyell",
        :opacity => 0.5
    )
]

opts = [("isColorbar", true)]
methods = [("setCrosshairWidth", 10)]

# in vscode: opens plot pane by default (to open in browser: ctr+shift+p -> deactivate plot pane)
# in REPL: opens browser by default
nv1 = niivue(volumes; opts, methods)

# change visualization interactively
nv1.setCrosshairWidth(1)
nv1.isColorbar = false
c = nv1.colormaps()

## Use Electron display instead
# in vscode: ctr+shift+p -> Julia: Disable Plot Pane
using Electron
Electron.use_electron_display(devtools=true)
