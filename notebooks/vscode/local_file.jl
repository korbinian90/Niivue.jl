## Installation
# import Pkg; Pkg.add(url="https://github.com/korbinian90/Niivue.jl")

## Usage
using Niivue

volume_local = [
    Dict(
        :url => raw"D:\MRSI\data\results2\hc_slurm\maps\Orig\GABA_amp_map.nii",
    )
]

nv1 = niivue(volume_local)
