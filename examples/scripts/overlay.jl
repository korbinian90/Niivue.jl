# Load two volumes as overlay and interactively adjust
using Niivue

nv = niivue(
    [
        Dict(:url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz", :colormap => "gray"),
        Dict(:url => "https://niivue.github.io/niivue-demo-images/hippo.nii.gz", :colormap => "red", :opacity => 0.7),
    ],
    opts = [("isColorbar", true)],
)

# Change settings interactively
nv.setCrosshairWidth(2)
nv.backColor = [0, 0, 0, 1]
