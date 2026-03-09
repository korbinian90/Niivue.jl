# ---
# title: Custom Synthetic Volume
# description: Create and display a procedurally generated sphere volume
# cover: custom_array.png
# ---

# Generate a synthetic sphere volume in Julia and
# display it directly — no files needed.
using Niivue

function create_sphere(dims=(64, 64, 32))
    arr = zeros(Float32, dims)
    center = dims .÷ 2
    radius = minimum(dims) ÷ 4
    for i in 1:dims[1], j in 1:dims[2], k in 1:dims[3]
        dist = sqrt(Float32((i-center[1])^2 + (j-center[2])^2 + (k-center[3])^2))
        if dist < radius
            arr[i,j,k] = 1.0f0 - (dist / radius)
        end
    end
    return arr
end

nv = niivue(create_sphere())
