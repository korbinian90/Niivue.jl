## Installation
# import Pkg; Pkg.add(url="https://github.com/korbinian90/Niivue.jl")

## Usage
using Niivue, NIfTI

function create_array(voxel_size=(1, 1, 1), dims=(64, 64, 32))
    test_array = zeros(Float32, dims)

    center = dims .÷ 2
    radius = minimum(dims .* voxel_size) ÷ 4

    for i in 1:dims[1], j in 1:dims[2], k in 1:dims[3]
        dist = sqrt(((i-center[1])*voxel_size[1])^2 + 
                    ((j-center[2])*voxel_size[2])^2 + 
                    ((k-center[3])*voxel_size[3])^2)
        if dist < radius
            test_array[i,j,k] = 1.0 - (dist/radius)
        end
    end

    return test_array
end

arr = create_array()
nv = niivue(arr)
##
voxel_size = (1, 1, 5) # Voxel size in mm
arr = create_array(voxel_size, (20, 20, 5))
nv = niivue(arr; voxel_size)
