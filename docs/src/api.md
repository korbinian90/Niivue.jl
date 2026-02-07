# API Reference

```@meta
CurrentModule = Niivue
```

## Main Function

```@docs
niivue
```

## Types

```@autodocs
Modules = [Niivue]
Order = [:type, :function]
```

## Methods and Options

Niivue.jl provides access to all NiiVue methods and options through a convenient Julia interface.

### Calling Methods

Methods can be called in several ways:

```julia
# Direct method call syntax (recommended)
nv.setCrosshairWidth(5)

# Functional syntax
nv("setCrosshairWidth", 5)
```

### Setting Options

Options can be set using property syntax:

```julia
nv.isColorbar = true
nv.backColor = [0.3, 0.3, 0.3, 1]
```

### Initialization Options

Options and methods can also be set during initialization:

```julia
nv = niivue(
    volumes,
    opts = [
        ("isColorbar", true),
        ("backColor", [1, 1, 1, 1]),
    ],
    methods = [
        ("setCrosshairWidth", 5),
    ]
)
```

## Complete API Reference

For the complete NiiVue API, refer to the official JavaScript documentation:

- **[Methods](https://niivue.com/docs/api/niivue/classes/Niivue#methods)** - All available methods like `setCrosshairWidth`, `setColormap`, etc.
- **[Options](https://niivue.com/docs/api/nvdocument/type-aliases/NVConfigOptions)** - All configurable options like `isColorbar`, `backColor`, etc.
- **[Colormaps](https://niivue.com/docs/api/colormaps)** - Available colormap schemes

### Commonly Used Methods

#### View Control
- `setSliceType(sliceType)` - Set view mode (axial, coronal, sagittal, multiplanar, 3D)
- `setClipPlane(clipPlane)` - Set 3D clipping plane
- `setPan2Dxyzmm(pan)` - Pan the 2D view

#### Crosshair
- `setCrosshairWidth(width)` - Set crosshair line width
- `setCrosshairColor(color)` - Set crosshair color as `[r, g, b, a]`
- `setInterpolation(interpolation)` - Set interpolation mode

#### Volume Control
- `setOpacity(volumeIndex, opacity)` - Set volume opacity (0-1)
- `setColormap(volumeIndex, colormap)` - Change volume colormap
- `setFrame4D(volumeIndex, frame)` - Navigate 4D volumes
- `removeVolume(volume)` - Remove a volume
- `loadVolumes(volumes)` - Load new volumes

#### Mesh Control
- `loadMeshes(meshes)` - Load 3D meshes
- `setMeshXRay(xray)` - Set mesh x-ray transparency
- `setMeshProperty(meshIndex, property, value)` - Set mesh properties

#### Rendering
- `setGamma(gamma)` - Set gamma correction
- `setSelectionBoxColor(color)` - Set selection box color
- `updateGLVolume()` - Force volume rendering update

### Commonly Used Options

#### Display Options
- `isColorbar` - Show/hide colorbar
- `backColor` - Background color as `[r, g, b, a]`
- `crosshairColor` - Crosshair color
- `show3Dcrosshair` - Show crosshair in 3D rendering

#### View Options
- `sliceType` - Slice display mode (0=Axial, 1=Coronal, 2=Sagittal, 3=Render, 4=Multiplanar)
- `meshXRay` - Mesh transparency (0-1)
- `isRadiologicalConvention` - Radiological vs neurological orientation

#### Interaction Options
- `dragMode` - Mouse drag behavior
- `viewModeHotKey` - Keyboard shortcut for changing views
- `isRuler` - Show/hide ruler

## Advanced Usage

### JavaScript Execution

For features not yet wrapped in the Julia interface, you can execute JavaScript directly:

```julia
using Niivue

nv = niivue()

# Execute JavaScript
js = Niivue.Bonito.js"""
window.nv.someMethod(someArgument)
"""
Niivue.Bonito.evaljs(nv.app.session.x, js)

# Get return values
js_return = Niivue.Bonito.js"""
window.nv.colormaps()
"""
result = Niivue.Bonito.evaljs_value(nv.app.session.x, js_return)
```

### Volume Data

Arrays are automatically converted to NIfTI format:

```julia
using Niivue

# Create from Julia array
data = rand(Float32, 100, 100, 50)
nv = niivue(data)

# With custom voxel dimensions
nv = niivue(data, voxel_size=(1.5, 1.5, 3.0))
```
