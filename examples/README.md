# Niivue.jl Examples

This directory contains examples demonstrating Niivue.jl usage in different Julia environments.

## Directory Structure

```
examples/
├── Pluto/          # Interactive Pluto notebooks (recommended for exploration)
├── vscode/         # Simple scripts for VSCode
└── Jupyter/        # Jupyter notebook examples
```

## Getting Started

### For Interactive Exploration: Use Pluto

Pluto notebooks provide the best interactive experience with reactive programming:

1. Install Pluto:
   ```julia
   import Pkg
   Pkg.add("Pluto")
   ```

2. Start Pluto:
   ```julia
   using Pluto
   Pluto.run()
   ```

3. Open any notebook from the `Pluto/` directory

**Recommended starting points:**
- `Pluto/test1.jl` - Basic usage with interactive controls
- `Pluto/basic_multiplanar.jl` - Multiplanar viewing
- `Pluto/colormaps.jl` - Interactive colormap controls

See [Pluto/README.md](Pluto/README.md) for complete list of examples.

### For Development: Use VSCode

VSCode integration provides a streamlined development experience:

1. Open VSCode with the Julia extension installed
2. Open any `.jl` file from the `vscode/` directory
3. Run the script (Shift+Enter)
4. View output in the integrated plot pane

**Available examples:**
- `vscode/test1.jl` - Basic usage with multiple volumes
- `vscode/array.jl` - Display Julia arrays
- `vscode/local_file.jl` - Load local NIfTI files

### For Jupyter Users

Traditional Jupyter notebook examples are available in `Jupyter/`:

1. Install IJulia:
   ```julia
   import Pkg
   Pkg.add("IJulia")
   ```

2. Start Jupyter:
   ```julia
   using IJulia
   notebook()
   ```

3. Open notebooks from the `Jupyter/` directory

## Example Categories

### Basic Usage
- Loading and displaying volumes
- Setting visualization options
- Interactive controls

### Viewing Modes
- Multiplanar view (axial, coronal, sagittal)
- 3D rendering
- Slice navigation

### Advanced Features
- Colormap customization
- 3D mesh visualization
- Brain atlas display
- 4D time series data
- Multiple volume overlays

## Feature Parity with ipyniivue

These examples are translated from [ipyniivue](https://github.com/niivue/ipyniivue/tree/main/examples) to demonstrate feature parity. Key translations include:

| ipyniivue Example | Niivue.jl Equivalent | Notes |
|-------------------|----------------------|-------|
| `basic_multiplanar.ipynb` | `Pluto/basic_multiplanar.jl` | Multiplanar viewing |
| `colormaps.ipynb` | `Pluto/colormaps.jl` | Interactive colormaps |
| `meshes.ipynb` | `Pluto/meshes.jl` | 3D mesh rendering |
| `atlas.ipynb` | `Pluto/atlas.jl` | Brain atlas display |
| `example_4d.ipynb` | `Pluto/4d_timeseries.jl` | Time series data |

For the complete list of ipyniivue examples (65+ notebooks), see the [ipyniivue examples directory](https://github.com/niivue/ipyniivue/tree/main/examples).

## Julia-Specific Advantages

The examples showcase several Julia-specific features:

1. **Pluto Reactivity**: Automatic updates without explicit callbacks
2. **VSCode Integration**: Built-in plot pane support
3. **REPL Interactivity**: Live manipulation from the Julia REPL
4. **Type Safety**: Compile-time error checking
5. **Performance**: JIT-compiled Julia code

See the [documentation](https://korbinian90.github.io/Niivue.jl/) for more details.

## Contributing Examples

We welcome contributions! To add a new example:

1. Choose the appropriate directory (Pluto, vscode, or Jupyter)
2. Create your example file
3. Follow the naming convention and style of existing examples
4. Add a description and link to the corresponding niivue demo if applicable
5. Update the relevant README (e.g., `Pluto/README.md`)
6. Submit a pull request

## Quick Reference

### Creating a Viewer

```julia
using Niivue

# From array
nv = niivue(rand(50, 50, 20))

# From URL
nv = niivue("https://niivue.github.io/niivue-demo-images/mni152.nii.gz")

# Multiple volumes
volumes = [
    Dict(:url => "mni152.nii.gz", :colormap => "gray"),
    Dict(:url => "overlay.nii.gz", :colormap => "red", :opacity => 0.5)
]
nv = niivue(volumes)
```

### Interactive Controls

```julia
# Call methods
nv.setCrosshairWidth(5)
nv.setCrosshairColor([0, 1, 1, 0.5])

# Set options
nv.isColorbar = true
nv.backColor = [0.3, 0.3, 0.3, 1]
```

### Display Options

```julia
# VSCode (default)
nv = niivue(volumes)  # Opens in plot pane

# Electron
using Electron
Electron.use_electron_display()
nv = niivue(volumes)  # Opens in Electron window

# Browser (default in REPL)
nv = niivue(volumes)  # Opens in default browser
```

## Resources

- [Niivue.jl Documentation](https://korbinian90.github.io/Niivue.jl/)
- [NiiVue JavaScript Documentation](https://niivue.com/docs/)
- [ipyniivue Examples](https://github.com/niivue/ipyniivue/tree/main/examples)
- [Pluto.jl](https://plutojl.org/)
- [VSCode Julia Extension](https://www.julia-vscode.org/)

## Need Help?

- Check the [documentation](https://korbinian90.github.io/Niivue.jl/)
- Browse the examples in this directory
- Open an issue on [GitHub](https://github.com/korbinian90/Niivue.jl/issues)
