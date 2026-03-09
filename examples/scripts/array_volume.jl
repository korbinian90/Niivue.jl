# Visualize a Julia array as a brain volume
using Niivue

nv = niivue(rand(Float32, 64, 64, 30))
