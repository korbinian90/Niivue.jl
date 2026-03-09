# Load a brain mesh with a curvature overlay
using Niivue

nv = niivue(meshes=[Dict(
    :url => "https://niivue.github.io/niivue-demo-images/BrainMesh_ICBM152.lh.mz3",
    :layers => [Dict(:url => "https://niivue.github.io/niivue-demo-images/BrainMesh_ICBM152.lh.curv.mz3")]
)])
