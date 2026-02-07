# Examples

Niivue.jl supports multiple Julia environments. Choose the one that best fits your workflow:

## Pluto Notebooks (Recommended for Interactive Exploration)

[Pluto.jl](https://github.com/fonsp/Pluto.jl) provides reactive, interactive notebooks ideal for exploration and teaching.

See the [Pluto examples directory](https://github.com/korbinian90/Niivue.jl/tree/main/examples/Pluto) for:
- Basic multiplanar viewing
- Colormap controls
- 3D mesh visualization
- Brain atlas display
- 4D time series data
- And more!

[View all Pluto examples →](https://github.com/korbinian90/Niivue.jl/tree/main/examples/Pluto/README.md)

## Quick Examples

### Basic Usage

```julia
using Niivue

# Display a random 3D array
arr = rand(50, 50, 20)
nv = niivue(arr)
```

### Load from URL

```julia
using Niivue

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
```

### Interactive Settings

```julia
using Niivue

nv = niivue()

# Call methods
nv.setCrosshairWidth(5)
nv.setCrosshairColor([0, 1, 1, 0.5])

# Set options
nv.isColorbar = true
```

### Load Local NIfTI Files

```julia
using Niivue

nv = niivue([
    Dict(
        :url => "path/to/your/file.nii.gz",
        :colormap => "gray",
    )
])
```

### Display in Different Environments

#### VSCode
By default, displays in the VSCode plot pane.

#### Electron Window
```julia
using Electron
Electron.use_electron_display(devtools=false)

using Niivue
nv = niivue(rand(50, 50, 20))
```

#### Browser
Just create a viewer - it will automatically open in your default browser:
```julia
using Niivue
nv = niivue(rand(50, 50, 20))
```

### Advanced: Direct JavaScript Execution

For features not yet wrapped in Julia syntax:

```julia
using Niivue

nv = niivue()
width = 10
js = Niivue.Bonito.js"""
window.nv.setCrosshairWidth($(width))
"""

Niivue.Bonito.evaljs(nv.app.session.x, js)
```

Return values from JavaScript:

```julia
using Niivue

nv = niivue()
js_return = Niivue.Bonito.js"""
window.nv.colormaps()
"""

cmaps = Niivue.Bonito.evaljs_value(nv.app.session.x, js_return)
```

## More Examples

- [Pluto Examples](https://github.com/korbinian90/Niivue.jl/tree/main/examples/Pluto) - Interactive notebooks
- [VSCode Examples](https://github.com/korbinian90/Niivue.jl/tree/main/examples/vscode) - Simple scripts
- [Jupyter Examples](https://github.com/korbinian90/Niivue.jl/tree/main/examples/Jupyter) - Jupyter notebooks

## Reference

For complete API documentation, see the [NiiVue JavaScript documentation](https://niivue.com/docs/):
- [Methods](https://niivue.com/docs/api/niivue/classes/Niivue#methods)
- [Options](https://niivue.com/docs/api/nvdocument/type-aliases/NVConfigOptions)
