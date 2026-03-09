# Clip planes: Interactive clip plane visualization
using Niivue

nv = niivue(
    "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
    opts=[("meshXRay", 0.02)],
    methods=[("setSliceType", 4)],
)

# Apply two clip planes
nv.setClipPlane([[0.1, 180, 20], [0.1, 0, -20]])
