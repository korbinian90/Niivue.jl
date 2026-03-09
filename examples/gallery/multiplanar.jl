# ---
# title: Multiplanar View
# description: Display brain volumes in a multiplanar (multi-slice) layout
# cover: multiplanar.png
# ---

# Show an MNI152 template with a hippocampus overlay
# in a multiplanar view with all three orientations
# and a 3D rendering.
using Niivue

volumes = [
    Dict(
        :url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
        :colormap => "gray",
    ),
    Dict(
        :url => "https://niivue.github.io/niivue-demo-images/hippo.nii.gz",
        :colormap => "red",
        :opacity => 0.7,
    ),
]

nv = niivue(
    volumes,
    opts = [
        ("sliceType", 4),
        ("isColorbar", true),
        ("backColor", [0, 0, 0.18, 1]),
    ],
)
