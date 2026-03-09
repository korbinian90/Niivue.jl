# ---
# title: Brain Mesh
# description: Load and display a 3D brain surface mesh with curvature overlay
# cover: mesh.png
# ---

# Visualize a brain surface mesh with an associated
# curvature layer overlay.
using Niivue

nv = niivue(meshes=[Dict(
    :url => "https://niivue.github.io/niivue-demo-images/BrainMesh_ICBM152.lh.mz3",
    :layers => [Dict(:url => "https://niivue.github.io/niivue-demo-images/BrainMesh_ICBM152.lh.curv.mz3")]
)])
