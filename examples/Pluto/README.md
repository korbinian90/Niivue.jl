# Niivue.jl Pluto Examples

This directory contains interactive [Pluto.jl](https://github.com/fonsp/Pluto.jl) notebooks demonstrating various features of Niivue.jl. These examples are translated from the [ipyniivue](https://github.com/niivue/ipyniivue) Python examples to showcase feature parity.

## Running the Examples

1. Install Pluto.jl:
   ```julia
   import Pkg
   Pkg.add("Pluto")
   ```

2. Start Pluto:
   ```julia
   using Pluto
   Pluto.run()
   ```

3. In the Pluto interface, open any of the example notebooks listed below.

## Available Examples

### Basic Examples

- **[test1.jl](test1.jl)** - Basic usage with interactive controls and control panel
  - Demonstrates loading volumes from URLs
  - Interactive crosshair and colorbar controls
  - PlutoUI integration for reactive interfaces

### Viewing Modes

- **[basic_multiplanar.jl](basic_multiplanar.jl)** - Multiplanar viewing mode
  - Displays volumes in axial, coronal, and sagittal views simultaneously
  - Multiple volume overlay
  - Interactive opacity and colormap controls

### Visualization Features

- **[colormaps.jl](colormaps.jl)** - Colormap controls and customization
  - Interactive colormap selection
  - Gamma correction
  - Crosshair customization
  - Demonstrates many built-in colormaps

- **[meshes.jl](meshes.jl)** - 3D mesh surface visualization
  - Loading brain mesh surfaces
  - Mesh transparency and x-ray modes
  - Multiple mesh layers

- **[atlas.jl](atlas.jl)** - Brain atlas visualization
  - Anatomical region labeling
  - Atlas overlays
  - Region identification

### Advanced Features

- **[4d_timeseries.jl](4d_timeseries.jl)** - 4D time series data
  - Viewing 3D volumes over time
  - Interactive timepoint navigation
  - fMRI BOLD data visualization

## Julia-Specific Advantages

These Pluto examples showcase several advantages of the Julia implementation:

1. **Reactive Programming**: Pluto's reactive cell execution makes it easy to create interactive visualizations with minimal code
2. **Type Safety**: Julia's type system helps catch errors early
3. **Performance**: Julia's JIT compilation provides excellent performance
4. **Integration**: Seamless integration with the Julia ecosystem (PlutoUI, other plotting libraries, etc.)
5. **Live Documentation**: Pluto notebooks serve as both documentation and executable code

## Comparison with ipyniivue

While maintaining feature parity with ipyniivue, Niivue.jl offers:

- **Pluto.jl Integration**: True reactive notebooks without explicit callbacks
- **VSCode Integration**: Built-in plotting pane support
- **REPL Interactivity**: Direct manipulation in the Julia REPL
- **Electron Display**: Optional standalone window display
- **Bonito.jl Foundation**: Modern web technology stack with WebGL

## Contributing Examples

To add new examples:

1. Create a new Pluto notebook in this directory
2. Follow the naming convention: `feature_name.jl`
3. Include:
   - A descriptive title and overview
   - Link to the corresponding niivue demo (if applicable)
   - Clear explanations of the demonstrated features
   - Interactive elements where appropriate
4. Update this README with your example

## More Information

- [Niivue.jl Documentation](https://korbinian90.github.io/Niivue.jl/)
- [NiiVue JavaScript Documentation](https://niivue.com/docs/)
- [ipyniivue Examples](https://github.com/niivue/ipyniivue/tree/main/examples)
- [Pluto.jl Documentation](https://plutojl.org/)
