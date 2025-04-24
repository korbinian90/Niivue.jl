# import Pkg; Pkg.add(url="https://github.com/korbinian90/Niivue.jl")

using Niivue

volumes = [
    Dict(
        :url => "https://niivue.github.io/niivue/images/mni152.nii.gz",
        :colormap => "gray",
    ),
    Dict(
        :url => "https://niivue.github.io/niivue/images/hippo.nii.gz",
        :colormap => "red",
    )
]

opts = [("isColorbar", true)]
methods = [("loadVolumes", volumes)]

nv1 = niivue(volumes; opts)
nv1.app

nv1.setCrosshairWidth(10)
nv1.isColorbar = true
# use_electron_display(devtools=true)
