### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 8f3a2b10-c5d0-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
end

# ╔═╡ 9f3a2b20-c5d0-11ef-1234-0123456789ab
using Niivue

# ╔═╡ a0b3c4d5-c5d0-11ef-1234-0123456789ab
md"""
# Basic Multiplanar View

This example demonstrates multiplanar viewing with multiple volumes.
Based on: https://niivue.github.io/niivue/features/basic.multiplanar.html
"""

# ╔═╡ b1c2d3e4-c5d0-11ef-1234-0123456789ab
volumes = [
    Dict(
        :url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
        :colormap => "gray",
        :opacity => 1.0,
    ),
    Dict(
        :url => "https://niivue.github.io/niivue-demo-images/hippo.nii.gz",
        :colormap => "red",
        :opacity => 1.0,
    )
]

# ╔═╡ c2d3e4f5-c5d0-11ef-1234-0123456789ab
nv = niivue(
	volumes,
	opts = [
		("sliceType", 4),  # MULTIPLANAR mode
		("show3Dcrosshair", true),
		("crosshairColor", [0, 1, 1, 1]),
		("backColor", [1, 1, 1, 1]),
		("clipPlaneColor", [0, 1, 1, 1]),
		("isColorbar", true),
	]
)

# ╔═╡ d3e4f5g6-c5d0-11ef-1234-0123456789ab
md"""
## Interactive Controls

You can modify the view settings interactively:
"""

# ╔═╡ e4f5g6h7-c5d0-11ef-1234-0123456789ab
# Adjust volume opacity
begin
	nv("setOpacity", (0, 0.3))  # Set first volume to 30% opacity
	nv("setColormap", (1, "blue"))  # Change second volume colormap to blue
end

# ╔═╡ Cell order:
# ╠═8f3a2b10-c5d0-11ef-1234-0123456789ab
# ╠═9f3a2b20-c5d0-11ef-1234-0123456789ab
# ╟─a0b3c4d5-c5d0-11ef-1234-0123456789ab
# ╠═b1c2d3e4-c5d0-11ef-1234-0123456789ab
# ╠═c2d3e4f5-c5d0-11ef-1234-0123456789ab
# ╟─d3e4f5g6-c5d0-11ef-1234-0123456789ab
# ╠═e4f5g6h7-c5d0-11ef-1234-0123456789ab
