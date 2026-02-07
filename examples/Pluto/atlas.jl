### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ a1b2c3d4-c5d4-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
end

# ╔═╡ b2c3d4e5-c5d4-11ef-1234-0123456789ab
using Niivue

# ╔═╡ c3d4e5f6-c5d4-11ef-1234-0123456789ab
md"""
# Atlas Visualization

This example demonstrates displaying brain atlases with labeled regions.
Based on: https://niivue.github.io/niivue/features/atlas.html
"""

# ╔═╡ d4e5f6g7-c5d4-11ef-1234-0123456789ab
volumes = [
    Dict(
        :url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
        :colormap => "gray",
    ),
    Dict(
        :url => "https://niivue.github.io/niivue-demo-images/aal.nii.gz",
        :colormap => "actc",
        :opacity => 0.5,
    )
]

# ╔═╡ e5f6g7h8-c5d4-11ef-1234-0123456789ab
nv = niivue(
	volumes,
	opts = [
		("isColorbar", true),
	]
)

# ╔═╡ f6g7h8i9-c5d4-11ef-1234-0123456789ab
md"""
## Atlas Features

Brain atlases in Niivue.jl:
- Display labeled anatomical regions
- Support various atlas formats (AAL, Desikan-Killiany, Harvard-Oxford, etc.)
- Interactive region identification
- Customizable colormaps for regions
- Overlay multiple atlases

The AAL (Automated Anatomical Labeling) atlas shown here provides anatomical parcellation of the brain into distinct regions.
"""

# ╔═╡ g7h8i9j0-c5d4-11ef-1234-0123456789ab
# Adjust atlas opacity for better visualization
nv("setOpacity", (1, 0.7))

# ╔═╡ Cell order:
# ╠═a1b2c3d4-c5d4-11ef-1234-0123456789ab
# ╠═b2c3d4e5-c5d4-11ef-1234-0123456789ab
# ╟─c3d4e5f6-c5d4-11ef-1234-0123456789ab
# ╠═d4e5f6g7-c5d4-11ef-1234-0123456789ab
# ╠═e5f6g7h8-c5d4-11ef-1234-0123456789ab
# ╟─f6g7h8i9-c5d4-11ef-1234-0123456789ab
# ╠═g7h8i9j0-c5d4-11ef-1234-0123456789ab
