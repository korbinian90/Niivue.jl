# Julia-Specific Features

Niivue.jl leverages Julia's unique features to provide an excellent neuroimaging visualization experience. This page highlights the advantages of using Niivue.jl compared to other implementations.

## Pluto.jl Integration

[Pluto.jl](https://github.com/fonsp/Pluto.jl) provides reactive notebooks that automatically update when values change.

### Reactive Interactivity

Unlike traditional notebooks, Pluto automatically determines dependencies and updates affected cells:

```julia
using Niivue, PlutoUI

nv = niivue(["https://niivue.github.io/niivue-demo-images/mni152.nii.gz"])

# Create interactive controls
@bind width Slider(1:10)
@bind colorbar CheckBox()

# These update automatically when the controls change!
nv.setCrosshairWidth(width)
nv.isColorbar = colorbar
```

No callbacks or event handlers needed - Pluto handles it automatically!

### Benefits
- **No explicit callbacks**: Pluto's reactivity eliminates boilerplate
- **Clean code**: Write declarative code instead of imperative callbacks
- **Reproducibility**: Notebooks can be re-run in any order
- **Package management**: Built-in package manager per notebook

## VSCode Integration

Niivue.jl automatically detects and uses the VSCode plot pane when available.

```julia
using Niivue

# Automatically displays in VSCode plot pane
nv = niivue(rand(50, 50, 20))
```

### Features
- **Integrated plotting pane**: Visualizations appear alongside your code
- **Multiple viewers**: Open multiple Niivue instances simultaneously
- **Plot history**: Navigate through previous visualizations
- **No browser needed**: Everything in one window

To disable and use Electron instead:
1. Open command palette (Ctrl+Shift+P)
2. Run: "Julia: Disable Plot Pane"

## REPL Interactivity

Modify your viewer interactively from the Julia REPL:

```julia
julia> using Niivue

julia> nv = niivue(rand(50, 50, 20))

julia> nv.setCrosshairWidth(10)

julia> nv.isColorbar = true

julia> nv.setCrosshairColor([0, 1, 1, 0.5])
```

Every change is immediately reflected in the viewer!

## Electron Display

For standalone window display:

```julia
using Electron
Electron.use_electron_display(devtools=false)

using Niivue
nv = niivue(volumes)
```

### Benefits
- **Standalone window**: Dedicated application window
- **DevTools**: Optional developer tools for debugging
- **Screen capture**: Easy screenshot and recording
- **Multi-monitor**: Move to separate monitor

## Type Safety

Julia's type system helps catch errors at development time:

```julia
# Type-safe array handling
data::Array{Float32, 3} = rand(Float32, 100, 100, 50)
nv = niivue(data)

# Compiler catches dimension mismatches
wrong_data::Array{Float32, 2} = rand(Float32, 100, 100)  # Will error if used incorrectly
```

## Performance

### JIT Compilation
Julia's JIT compiler optimizes code paths for better performance.

### Efficient Array Handling
Direct array conversion to NIfTI without intermediate copies:

```julia
using Niivue

# Efficient - no unnecessary copies
large_data = rand(Float32, 256, 256, 256)
nv = niivue(large_data)
```

### Lazy Loading
Volumes are loaded and processed efficiently using Julia's memory management.

## Ecosystem Integration

### Works with Julia Packages

```julia
using Niivue
using Images, FileIO

# Load image with Images.jl
img = load("brain.nii.gz")

# Convert and visualize
nv = niivue(Float32.(img))
```

### Plotting Integration

```julia
using Niivue
using Plots

# Combine with other visualizations
p = plot(1:10, rand(10))
nv = niivue(rand(50, 50, 20))

# Display both
display(p)
display(nv)
```

## Modern Web Stack

Built on [Bonito.jl](https://github.com/SimonDanisch/Bonito.jl):
- WebGL rendering
- Modern JavaScript (ES modules)
- Efficient client-server communication
- Observable-based reactivity

## Comparison with ipyniivue

| Feature | Niivue.jl | ipyniivue |
|---------|-----------|-----------|
| **Reactive Notebooks** | ✅ Pluto (automatic) | ⚠️ Jupyter (manual callbacks) |
| **IDE Integration** | ✅ VSCode plot pane | ❌ No native support |
| **REPL Interactivity** | ✅ Full support | ⚠️ Limited |
| **Type Safety** | ✅ Static typing | ❌ Dynamic only |
| **Performance** | ✅ JIT compiled | ⚠️ Interpreted |
| **Standalone Display** | ✅ Electron | ❌ Browser only |
| **Package Management** | ✅ Built-in | ⚠️ pip/conda |

Both implementations provide feature parity for core NiiVue functionality!

## Example Workflow

Here's a typical workflow showcasing Julia-specific advantages:

```julia
# 1. Quick REPL exploration
using Niivue
nv = niivue(rand(50, 50, 20))
nv.isColorbar = true

# 2. Create interactive Pluto notebook
using Pluto
Pluto.run()
# Open examples/Pluto/colormaps.jl

# 3. Process with Julia packages
using NIfTI, Statistics

# Load real data
vol = niread("fmri_data.nii.gz")

# Process with Julia's fast statistics
mean_signal = mean(vol, dims=4)

# Visualize
nv = niivue(mean_signal)

# 4. Share as reproducible Pluto notebook
# The notebook is automatically reproducible and shareable!
```

## Getting Started

Try these Julia-specific features:

1. **Start with Pluto**: Best for interactive exploration
   ```julia
   using Pluto
   Pluto.run()
   ```

2. **Use VSCode**: Best for development workflow
   - Open the examples/vscode directory
   - Run any .jl file
   - View output in plot pane

3. **Experiment in REPL**: Best for quick tests
   ```julia
   julia> using Niivue
   julia> nv = niivue(rand(50, 50, 20))
   ```

Choose the environment that fits your workflow!
