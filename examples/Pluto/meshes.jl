### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ a1b2c3d4-c5d2-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
end

# ╔═╡ b2c3d4e5-c5d2-11ef-1234-0123456789ab
using Niivue

# ╔═╡ c3d4e5f6-c5d2-11ef-1234-0123456789ab
md"""
# Mesh Visualization

This example demonstrates loading and displaying 3D mesh surfaces.
Based on: https://niivue.github.io/niivue/features/meshes.html
"""

# ╔═╡ d4e5f6g7-c5d2-11ef-1234-0123456789ab
meshes = [
	Dict(:url => "https://niivue.github.io/niivue-demo-images/BrainMesh_ICBM152.lh.mz3"),
	Dict(:url => "https://niivue.github.io/niivue-demo-images/BrainMesh_ICBM152.rh.mz3"),
]

# ╔═╡ e5f6g7h8-c5d2-11ef-1234-0123456789ab
nv = niivue(
	methods = [
		("loadMeshes", meshes),
	],
	opts = [
		("backColor", [0.2, 0.2, 0.2, 1]),
		("meshXRay", 0.0),
	]
)

# ╔═╡ f6g7h8i9-c5d2-11ef-1234-0123456789ab
md"""
## Mesh Controls

Adjust mesh transparency and rendering:
"""

# ╔═╡ g7h8i9j0-c5d2-11ef-1234-0123456789ab
# Set mesh x-ray mode for semi-transparent rendering
nv("setMeshXRay", 0.3)

# ╔═╡ h8i9j0k1-c5d2-11ef-1234-0123456789ab
md"""
## Mesh Features

Niivue.jl supports:
- Loading various mesh formats (MZ3, GIfTI, FreeSurfer, etc.)
- Mesh colormaps and overlays
- Multiple mesh layers
- Interactive rotation and zooming
- Mesh transparency and x-ray modes
"""

# ╔═╡ Cell order:
# ╠═a1b2c3d4-c5d2-11ef-1234-0123456789ab
# ╠═b2c3d4e5-c5d2-11ef-1234-0123456789ab
# ╟─c3d4e5f6-c5d2-11ef-1234-0123456789ab
# ╠═d4e5f6g7-c5d2-11ef-1234-0123456789ab
# ╠═e5f6g7h8-c5d2-11ef-1234-0123456789ab
# ╟─f6g7h8i9-c5d2-11ef-1234-0123456789ab
# ╠═g7h8i9j0-c5d2-11ef-1234-0123456789ab
# ╟─h8i9j0k1-c5d2-11ef-1234-0123456789ab
