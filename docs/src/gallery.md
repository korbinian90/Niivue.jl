# Example Gallery

This gallery showcases interactive Pluto.jl notebooks demonstrating various features of Niivue.jl. All examples are translated from [ipyniivue](https://github.com/niivue/ipyniivue) to demonstrate feature parity with reactive Julia interfaces.

## How to Run Examples

1. Install and start Pluto:
   ```julia
   import Pkg
   Pkg.add("Pluto")
   using Pluto
   Pluto.run()
   ```

2. In the Pluto interface, navigate to the `examples/Pluto` directory and open any notebook.

3. Each notebook is self-contained and will install required dependencies automatically.

---

## Basic Usage

### Interactive Controls Demo
**[test1.jl](https://github.com/korbinian90/Niivue.jl/blob/main/examples/Pluto/test1.jl)**

A comprehensive introduction to Niivue.jl with interactive controls and PlutoUI integration.

**Features:**
- Loading volumes from URLs
- Interactive crosshair customization
- Colorbar controls
- Reactive parameter updates with PlutoUI sliders and checkboxes

**Key concepts:** Basic viewer creation, method calls, option setting

---

## Viewing Modes

### Multiplanar View
**[basic_multiplanar.jl](https://github.com/korbinian90/Niivue.jl/blob/main/examples/Pluto/basic_multiplanar.jl)**

Display multiple anatomical views simultaneously (axial, coronal, sagittal).

**Features:**
- Simultaneous three-plane viewing
- Volume overlay with opacity control
- Interactive colormap switching

**Use cases:** Clinical radiology workflows, anatomical orientation

---

### Mosaic Layout
**[mosaic.jl](https://github.com/korbinian90/Niivue.jl/blob/main/examples/Pluto/mosaic.jl)**

Create tiled layouts showing multiple slices at once.

**Features:**
- Customizable mosaic string format
- Grid-based slice arrangement
- Comprehensive brain coverage in single view

**Use cases:** Creating brain atlases, quality control, publications

---

### Custom Layouts
**[layout.jl](https://github.com/korbinian90/Niivue.jl/blob/main/examples/Pluto/layout.jl)**

Flexible viewport arrangements for multi-view displays.

**Features:**
- Auto, column, grid, and row layout modes
- Interactive layout switching
- Workspace organization

**Use cases:** Customized viewing workflows, presentations

---

## Visualization Features

### Colormap Controls
**[colormaps.jl](https://github.com/korbinian90/Niivue.jl/blob/main/examples/Pluto/colormaps.jl)**

Comprehensive colormap customization with interactive controls.

**Features:**
- Multiple built-in colormaps (thermal, rainbow, medical)
- Gamma correction
- Crosshair color and width adjustment
- Real-time parameter updates

**Use cases:** Optimizing contrast, publication figures, preference customization

---

### Brain Atlas
**[atlas.jl](https://github.com/korbinian90/Niivue.jl/blob/main/examples/Pluto/atlas.jl)**

Display anatomical parcellation atlases with labeled regions.

**Features:**
- Atlas overlay on structural images
- Region identification
- Adjustable opacity

**Supported atlases:** AAL, Desikan-Killiany, Harvard-Oxford, and more

**Use cases:** Anatomical localization, ROI definition, teaching

---

## 3D Surface Visualization

### Basic Mesh Rendering
**[meshes.jl](https://github.com/korbinian90/Niivue.jl/blob/main/examples/Pluto/meshes.jl)**

Visualize 3D brain surface meshes.

**Features:**
- Multiple mesh formats (MZ3, GIfTI, FreeSurfer)
- Mesh transparency and x-ray modes
- Multiple mesh layers

**Use cases:** Surface-based analysis, cortical visualization

---

### Mesh with Curvature
**[mesh_curvature.jl](https://github.com/korbinian90/Niivue.jl/blob/main/examples/Pluto/mesh_curvature.jl)**

Brain surfaces with cortical folding pattern overlays.

**Features:**
- Curvature map visualization
- Gyri and sulci identification
- Layer-based mesh rendering

**Use cases:** Surface quality control, morphometry, anatomical landmarks

---

## Advanced Features

### 4D Time Series
**[4d_timeseries.jl](https://github.com/korbinian90/Niivue.jl/blob/main/examples/Pluto/4d_timeseries.jl)**

Navigate through 3D volumes over time.

**Features:**
- Frame-by-frame navigation
- Interactive timepoint slider
- Dynamic volume updates

**Use cases:** fMRI BOLD data, perfusion imaging, dynamic scans

---

### Connectome Visualization
**[connectome.jl](https://github.com/korbinian90/Niivue.jl/blob/main/examples/Pluto/connectome.jl)**

Display brain connectivity with nodes and edges.

**Features:**
- Network node positioning
- Connection strength visualization
- Color-coded networks
- Interactive node scaling

**Use cases:** DTI tractography, functional connectivity, effective connectivity

---

### Drawing and Annotation
**[drawing.jl](https://github.com/korbinian90/Niivue.jl/blob/main/examples/Pluto/drawing.jl)**

Interactive tools for manual annotation and ROI definition.

**Features:**
- Pen drawing tool
- Multiple color labels
- Filled/outline modes
- Drawing layer management

**Use cases:** Manual segmentation, ROI definition, annotation

---

## Julia-Specific Features

All examples showcase Julia-specific advantages:

### Reactive Programming
Pluto's reactive execution automatically updates visualizations when parameters change:

```julia
@bind width Slider(1:10)

# Automatically updates when slider moves
nv.setCrosshairWidth(width)
```

No callbacks or event handlers needed!

### Type Safety
Julia's type system catches errors at development time:

```julia
# Compiler ensures correct array dimensions
data::Array{Float32, 3} = rand(Float32, 100, 100, 50)
nv = niivue(data)
```

### Performance
JIT compilation provides efficient processing:

```julia
# Fast array operations
large_data = rand(Float32, 256, 256, 256)
nv = niivue(large_data)  # Efficient conversion to NIfTI
```

### Ecosystem Integration
Seamless integration with Julia packages:

```julia
using Images, Statistics

# Load and process with Julia ecosystem
img = load("scan.nii.gz")
processed = normalize(Float32.(img))
nv = niivue(processed)
```

---

## Comparison with ipyniivue

These examples demonstrate feature parity with ipyniivue while showcasing Julia advantages:

| Feature | Niivue.jl (Pluto) | ipyniivue (Jupyter) |
|---------|-------------------|---------------------|
| **Reactivity** | ✅ Automatic (built-in) | ⚠️ Manual callbacks |
| **Type Safety** | ✅ Static typing | ❌ Dynamic only |
| **Performance** | ✅ JIT compiled | ⚠️ Interpreted |
| **IDE Integration** | ✅ VSCode plot pane | ❌ Browser only |
| **Package Management** | ✅ Per-notebook | ⚠️ Global environment |
| **Interactive Controls** | ✅ PlutoUI (reactive) | ✅ ipywidgets |

---

## Contributing Examples

We welcome contributions of new examples! To add an example:

1. Create a Pluto notebook in `examples/Pluto/`
2. Follow the existing naming convention
3. Include:
   - Clear title and description
   - Link to corresponding niivue demo
   - Explanatory markdown cells
   - Interactive elements where appropriate
4. Update this gallery and the Pluto README
5. Submit a pull request

---

## Resources

- [View all examples on GitHub](https://github.com/korbinian90/Niivue.jl/tree/main/examples/Pluto)
- [NiiVue JavaScript Documentation](https://niivue.com/docs/)
- [ipyniivue Examples](https://github.com/niivue/ipyniivue/tree/main/examples)
- [Pluto.jl Documentation](https://plutojl.org/)
