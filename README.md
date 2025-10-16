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

The [methods](https://niivue.com/docs/api/niivue/classes/Niivue#methods) (e.g. `nv.setCrosshairWidth(5)`) and [options](https://niivue.com/docs/api/nvdocument/type-aliases/NVConfigOptions) (e.g. `nv.isColorbar = true`) can be found in the [niivue javascript documentation](https://niivue.com/docs/).

## Electron Display

To use an Electron display instead of the browser, add in the beginning

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

Return a value from javascript to julia:

```julia
using Niivue

nv = niivue()
js_return = Niivue.Bonito.js"""
window.nv.colormaps()
"""

cmaps = Niivue.Bonito.evaljs_value(nv.app.session.x, js_return)
```

## Future plans

- use niivue-vscode as alternative pre-configured viewer
- Support access to volumes (e.g. `nv.volumes[1].opacity = 0.3`) and functions with return values (e.g. `cmaps = nv.colormaps()`) directly from julia
- observable in julia that stores the crosshair location
