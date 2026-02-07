### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ a1b2c3d4-c5d9-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
end

# ╔═╡ b2c3d4e5-c5d9-11ef-1234-0123456789ab
using Niivue

# ╔═╡ c3d4e5f6-c5d9-11ef-1234-0123456789ab
md"""
# Mesh with Curvature Overlay

This example shows 3D brain surface meshes with curvature maps.
Based on: https://niivue.github.io/niivue/features/mesh.curv.html
"""

# ╔═╡ d4e5f6g7-c5d9-11ef-1234-0123456789ab
meshes = [
	Dict(
		:url => "https://niivue.github.io/niivue-demo-images/BrainMesh_ICBM152.lh.mz3",
		:layers => [
			Dict(:url => "https://niivue.github.io/niivue-demo-images/BrainMesh_ICBM152.lh.curv.mz3")
		]
	),
]

# ╔═╡ e5f6g7h8-c5d9-11ef-1234-0123456789ab
nv = niivue(
	methods = [
		("loadMeshes", meshes),
	],
	opts = [
		("backColor", [1, 1, 1, 1]),
		("meshXRay", 0.0),
	]
)

# ╔═╡ f6g7h8i9-c5d9-11ef-1234-0123456789ab
md"""
## Curvature Visualization

Curvature maps show the folding pattern of the cortex:
- **Gyri** (hills/ridges): Appear in one color
- **Sulci** (valleys/grooves): Appear in contrasting color

This is useful for:
- Surface-based morphometry
- Cortical thickness analysis  
- Identifying anatomical landmarks
- Quality control of surface reconstruction
"""

# ╔═╡ g7h8i9j0-c5d9-11ef-1234-0123456789ab
# Adjust mesh transparency
nv("setMeshXRay", 0.2)

# ╔═╡ h8i9j0k1-c5d9-11ef-1234-0123456789ab
md"""
## Mesh Overlays

Mesh layers can include:
- Curvature maps (sulcal/gyral patterns)
- Thickness measurements
- Functional activations
- Parcellation labels
- Statistical maps
"""

# ╔═╡ Cell order:
# ╠═a1b2c3d4-c5d9-11ef-1234-0123456789ab
# ╠═b2c3d4e5-c5d9-11ef-1234-0123456789ab
# ╟─c3d4e5f6-c5d9-11ef-1234-0123456789ab
# ╠═d4e5f6g7-c5d9-11ef-1234-0123456789ab
# ╠═e5f6g7h8-c5d9-11ef-1234-0123456789ab
# ╟─f6g7h8i9-c5d9-11ef-1234-0123456789ab
# ╠═g7h8i9j0-c5d9-11ef-1234-0123456789ab
# ╟─h8i9j0k1-c5d9-11ef-1234-0123456789ab
