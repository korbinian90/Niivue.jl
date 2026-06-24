# ---
# title: Random Array Volume
# description: Display a random Julia array as a brain volume
# cover: array_volume.png
# ---

# The simplest way to visualize volumetric data:
# pass a Julia array directly to niivue.
using Niivue

nv = niivue(rand(Float32, 64, 64, 30))
