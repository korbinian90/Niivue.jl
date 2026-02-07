```@meta
CurrentModule = Niivue
```

# Niivue.jl

An interactive WebGL-based neuroimaging viewer for Julia, built on top of [Bonito.jl](https://github.com/SimonDanisch/Bonito.jl) and [NiiVue](https://github.com/niivue/niivue).

![ Screenshot of a Niivue.jl view, showing a NIfTI file and random array together. The viewer renders directly in the VS Code plot pane. NiiVue settings can be modified interactively in the REPL](https://raw.githubusercontent.com/korbinian90/Niivue.jl/main/niivue.jl.png)

## Features

- 🧠 **Neuroimaging Visualization**: View NIfTI files, 3D meshes, and brain atlases
- 📊 **Multiple Environments**: Works in Pluto, Jupyter, VSCode, and the REPL
- ⚡ **Interactive**: Real-time manipulation of visualization settings
- 🎨 **Rich Features**: Colormaps, overlays, 4D time series, mesh rendering
- 🔬 **Scientific**: Designed for neuroscience research and medical imaging
- 🌐 **WebGL Powered**: High-performance 3D rendering in the browser

## Quick Start

### Installation

This package is not yet registered. Install via:

```julia
import Pkg
Pkg.add(url="https://github.com/korbinian90/Niivue.jl")
```

### Basic Usage

```julia
using Niivue

# Display a random 3D array
arr = rand(50, 50, 20)
nv = niivue(arr)

# Load from URL
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
nv = niivue(volumes)

# Interactive controls
nv.setCrosshairWidth(5)
nv.setCrosshairColor([0, 1, 1, 0.5])
nv.isColorbar = true
```

## Feature Parity with ipyniivue

Niivue.jl provides feature parity with [ipyniivue](https://github.com/niivue/ipyniivue), including:

- ✅ Volume visualization (NIfTI, MGH, etc.)
- ✅ 3D mesh rendering (FreeSurfer, GIfTI, MZ3, etc.)
- ✅ Brain atlas support
- ✅ 4D time series data
- ✅ Multiple colormaps and overlays
- ✅ Interactive controls
- ✅ Multiplanar viewing
- ✅ Custom rendering options

See the [Example Gallery](@ref) for a comprehensive showcase of interactive Pluto notebooks, or the [Examples](@ref) section for usage patterns.

## Why Niivue.jl?

### Julia-Specific Advantages

- **Pluto.jl Integration**: Reactive notebooks with automatic updates
- **VSCode Plot Pane**: Integrated viewing without browser tabs
- **REPL Interactivity**: Live manipulation from the Julia REPL
- **Type Safety**: Catch errors at development time
- **Performance**: JIT compilation for efficient processing
- **Ecosystem**: Seamless integration with Julia packages

See [Julia-Specific Features](@ref) for details.

## Documentation Contents

```@contents
Pages = [
    "gallery.md",
    "examples.md",
    "julia_features.md",
    "api.md",
]
```

## Acknowledgements

Development of an initial prototype was supported by Chris Rorden (University of South Carolina).

Built on top of:
- [NiiVue](https://github.com/niivue/niivue) - WebGL neuroimaging visualization library
- [Bonito.jl](https://github.com/SimonDanisch/Bonito.jl) - Julia web framework
- [NIfTI.jl](https://github.com/JuliaIO/NIfTI.jl) - NIfTI file format support
