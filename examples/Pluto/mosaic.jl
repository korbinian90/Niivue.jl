### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ a1b2c3d4-c5d5-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
end

# ╔═╡ b2c3d4e5-c5d5-11ef-1234-0123456789ab
using Niivue

# ╔═╡ c3d4e5f6-c5d5-11ef-1234-0123456789ab
md"""
# Mosaic View

This example demonstrates mosaic (tiled) slice layouts for viewing multiple slices at once.
Based on: https://niivue.github.io/niivue/features/mosaic.html
"""

# ╔═╡ d4e5f6g7-c5d5-11ef-1234-0123456789ab
nv = niivue(
	[Dict(
		:url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
		:colormap => "gray",
	)],
	opts = [
		("sliceMosaicString", "A 0 20 C 30 S 42"),  # Mosaic layout specification
		("isColorbar", false),
	]
)

# ╔═╡ e5f6g7h8-c5d5-11ef-1234-0123456789ab
md"""
## Mosaic String Format

The mosaic string controls the slice layout:
- Format: "PLANE SLICE PLANE SLICE ..."
- Planes: A (axial), C (coronal), S (sagittal)
- Examples:
  - `"A 0 20"` - Axial slices 0-20
  - `"C 30"` - Coronal slice 30
  - `"S 42"` - Sagittal slice 42

Try different mosaic patterns:
"""

# ╔═╡ f6g7h8i9-c5d5-11ef-1234-0123456789ab
# Change to show all three planes
nv("setSliceMosaicString", "A 0 C 0 S 0")

# ╔═╡ g7h8i9j0-c5d5-11ef-1234-0123456789ab
md"""
## Advanced Mosaic

Create a comprehensive brain atlas view with multiple slices:
"""

# ╔═╡ h8i9j0k1-c5d5-11ef-1234-0123456789ab
# Show multiple axial slices in a grid
nv("setSliceMosaicString", "A 0 10 20 30 40 50 60 70")

# ╔═╡ Cell order:
# ╠═a1b2c3d4-c5d5-11ef-1234-0123456789ab
# ╠═b2c3d4e5-c5d5-11ef-1234-0123456789ab
# ╟─c3d4e5f6-c5d5-11ef-1234-0123456789ab
# ╠═d4e5f6g7-c5d5-11ef-1234-0123456789ab
# ╟─e5f6g7h8-c5d5-11ef-1234-0123456789ab
# ╠═f6g7h8i9-c5d5-11ef-1234-0123456789ab
# ╟─g7h8i9j0-c5d5-11ef-1234-0123456789ab
# ╠═h8i9j0k1-c5d5-11ef-1234-0123456789ab
