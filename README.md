# Niivue

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://korbinian90.github.io/Niivue.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://korbinian90.github.io/Niivue.jl/dev/)
[![Build Status](https://github.com/korbinian90/Niivue.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/korbinian90/Niivue.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/korbinian90/Niivue.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/korbinian90/Niivue.jl)

## Quickstart

This should work in almost any julia environment (REPL, vscode, Pluto, Jupyter)

```julia
using Niivue

arr = rand(50,50,20)
nv = niivue(arr)
```

## Use settings

```julia
using Niivue

nv = niivue()
display(nv.app) ## currently required to display, run in own cell

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

nv.loadVolumes(volumes)
nv.setCrosshairWidth(5)
nv.setCrosshairColor([0,1,1,0.5])
nv.isColorbar = true
```

## Electron Display

To use an Electron display, add in the beginning

```julia
using Electron
use_electron_display(devtools=false)
```

In vscode, by default the plot pane is used. To use the Electron display, deactivate the plotting pane via the command palette (ctrl+shift+p) -> Julia: Disable Plot Pane

## Examples

Have a look at the 'examples' subfolder.

## Future plans

- use niivue-vscode as alternative pre-configured viewer
