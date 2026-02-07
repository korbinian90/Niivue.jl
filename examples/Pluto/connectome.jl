### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ a1b2c3d4-c5d7-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
end

# ╔═╡ b2c3d4e5-c5d7-11ef-1234-0123456789ab
using Niivue

# ╔═╡ c3d4e5f6-c5d7-11ef-1234-0123456789ab
md"""
# Connectome Visualization

This example demonstrates brain connectivity visualization with nodes and edges.
Based on: https://niivue.github.io/niivue/features/connect.html
"""

# ╔═╡ d4e5f6g7-c5d7-11ef-1234-0123456789ab
volumes = [
	Dict(
		:url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
		:colormap => "gray",
		:opacity => 0.4,
	)
]

# ╔═╡ e5f6g7h8-c5d7-11ef-1234-0123456789ab
# Define connectome data
connectome = Dict(
	:name => "test.jcon",
	:nodeColormap => "warm",
	:nodeMinColor => 2,
	:nodeMaxColor => 4,
	:nodeScale => 3,
	:edgeColormap => "warm",
	:edgeMin => 2,
	:edgeMax => 6,
	:edgeScale => 1,
	:nodes => [
		Dict(:name => "RF", :x => 40.92, :y => 22.04, :z => 31.03, :colorValue => 2, :sizeValue => 5),
		Dict(:name => "LF", :x => -41.38, :y => 21.3, :z => 30.44, :colorValue => 4, :sizeValue => 5),
		Dict(:name => "RT", :x => 57.43, :y => -38.17, :z => 23.59, :colorValue => 3, :sizeValue => 5),
		Dict(:name => "LT", :x => -56.59, :y => -37.99, :z => 22.56, :colorValue => 3, :sizeValue => 5),
	],
	:edges => [
		Dict(:first => 0, :second => 1, :colorValue => 2),
		Dict(:first => 0, :second => 2, :colorValue => 4),
		Dict(:first => 0, :second => 3, :colorValue => 6),
		Dict(:first => 1, :second => 2, :colorValue => 6),
		Dict(:first => 1, :second => 3, :colorValue => 4),
		Dict(:first => 2, :second => 3, :colorValue => 2),
	]
)

# ╔═╡ f6g7h8i9-c5d7-11ef-1234-0123456789ab
nv = niivue(
	volumes,
	methods = [
		("loadConnectome", connectome),
	],
	opts = [
		("sliceType", 3),  # 3D render mode
		("backColor", [0.2, 0.2, 0.2, 1]),
	]
)

# ╔═╡ g7h8i9j0-c5d7-11ef-1234-0123456789ab
md"""
## Connectome Features

This visualization shows:
- **Nodes**: Brain regions as colored spheres
  - Size represents importance
  - Color indicates functional network
- **Edges**: Connections between regions
  - Thickness shows connection strength
  - Color indicates connectivity type

Connectomes are useful for:
- Structural connectivity (DTI tractography)
- Functional connectivity (fMRI correlations)
- Effective connectivity (causal models)
"""

# ╔═╡ h8i9j0k1-c5d7-11ef-1234-0123456789ab
# Adjust node display
nv("setConnectomeNodeScale", 5.0)

# ╔═╡ Cell order:
# ╠═a1b2c3d4-c5d7-11ef-1234-0123456789ab
# ╠═b2c3d4e5-c5d7-11ef-1234-0123456789ab
# ╟─c3d4e5f6-c5d7-11ef-1234-0123456789ab
# ╠═d4e5f6g7-c5d7-11ef-1234-0123456789ab
# ╠═e5f6g7h8-c5d7-11ef-1234-0123456789ab
# ╠═f6g7h8i9-c5d7-11ef-1234-0123456789ab
# ╟─g7h8i9j0-c5d7-11ef-1234-0123456789ab
# ╠═h8i9j0k1-c5d7-11ef-1234-0123456789ab
