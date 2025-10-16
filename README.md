# Niivue

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://korbinian90.github.io/Niivue.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://korbinian90.github.io/Niivue.jl/dev/)
[![Build Status](https://github.com/korbinian90/Niivue.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/korbinian90/Niivue.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/korbinian90/Niivue.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/korbinian90/Niivue.jl)

## Installation

This package is not registered yet. Installation can be performed via

```julia
import Pkg
Pkg.add(url="https://github.com/korbinian90/Niivue.jl")
```

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
        :url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
        :colormap => "gray",
    ),
    Dict(
        :url => "https://niivue.github.io/niivue-demo-images/spmMotor.nii.gz", 
        :colormap => "redyell",
        :opacity => 0.5,
    )
]

nv.loadVolumes(volumes)
nv.setCrosshairWidth(5)
nv.setCrosshairColor([0,1,1,0.5])
nv.isColorbar = true
```

The [methods](https://niivue.github.io/niivue/devdocs/classes/Niivue.html) (e.g. `nv.setCrosshairWidth(5)`) and [options](https://niivue.github.io/niivue/devdocs/types/NVConfigOptions.html) (e.g. `nv.isColorbar = true`) can be found in the [niivue javascript documentation](https://niivue.github.io/niivue/devdocs/index.html).

## Electron Display

To use an Electron display, add in the beginning

```julia
using Electron
use_electron_display(devtools=false)
```

In vscode, by default the plot pane is used. To use the Electron display, deactivate the plotting pane via the command palette (ctrl+shift+p) -> Julia: Disable Plot Pane

## Examples

Have a look at the 'examples' subfolder.

## Hacking

Javascript can be directly executed from Julia and the `nv` object is available as `window.nv`

```julia
using Niivue

nv = niivue()
width = 10
js = Niivue.Bonito.js"""
window.nv.setCrosshairWidth($(width))
"""

Niivue.Bonito.evaljs(nv.app.session.x, js)
```

## Future plans

- use niivue-vscode as alternative pre-configured viewer
