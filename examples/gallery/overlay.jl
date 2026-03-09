# ---
# title: Volume Overlay
# description: Load two brain volumes with different colormaps as an overlay
# cover: overlay.png
# ---

# Load an anatomical base image (gray) and overlay an
# activation map (red) with transparency.
using Niivue

nv = niivue(
    [
        Dict(:url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz", :colormap => "gray"),
        Dict(:url => "https://niivue.github.io/niivue-demo-images/hippo.nii.gz", :colormap => "red", :opacity => 0.7),
    ],
    opts = [("isColorbar", true)],
)
