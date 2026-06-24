### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ a1b2c3d4-d7e0-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
	Pkg.add("PlutoUI")
end

# ╔═╡ b2c3d4e5-d7e0-11ef-1234-0123456789ab
using Niivue, PlutoUI

# ╔═╡ c3d4e5f6-d7e0-11ef-1234-0123456789ab
md"""
# Clip Planes

Clip planes transect the voxel-based volume rendering, revealing internal
structures. This example mirrors the
[NiiVue clip planes demo](https://niivue.com/demos/features/clipplanesmulti.html)
and the [ipyniivue clipplanes notebook](https://github.com/niivue/ipyniivue/blob/main/examples/clipplanes.ipynb).
"""

# ╔═╡ d4e5f6g7-d7e0-11ef-1234-0123456789ab
nv = niivue(
	[Dict(
		:url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
		:colormap => "gray",
		:opacity => 1.0,
	)],
	opts = [("meshXRay", 0.02)],
	methods = [("setSliceType", 4)],  # RENDER mode = 4
)

# ╔═╡ e4f5g6h7-d7e0-11ef-1234-0123456789ab
md"""
## Controls

**Number of clip planes:** $(@bind num_planes Select(["0", "1", "2", "3", "4", "5", "6"], default="2"))

**Shade:** $(@bind shade Select(["none", "outside", "inside"], default="outside"))
"""

# ╔═╡ f5g6h7i8-d7e0-11ef-1234-0123456789ab
# Apply clip planes based on selection
begin
	n = parse(Int, num_planes)
	planes = if n == 0
		[[2.0, 180, 20]]  # no clip (depth > 1)
	elseif n == 1
		[[0.1, 180, 20]]
	elseif n == 2
		[[0.1, 180, 20], [0.1, 0, -20]]
	elseif n == 3
		[[0.0, 90, 0], [0.0, 0, -20], [0.1, 0, -90]]
	elseif n == 4
		[[0.3, 270, 0], [0.3, 90, 0], [0.0, 180, 0], [0.1, 0, 0]]
	elseif n == 5
		[[0.4, 270, 0], [0.4, 90, 0], [0.4, 180, 0], [0.2, 0, 0], [0.1, 0, -90]]
	else
		[[0.4, 270, 0], [-0.1, 90, 0], [0.4, 180, 0], [0.2, 0, 0], [0.1, 0, -90], [0.3, 0, 90]]
	end
	nv.setClipPlane(planes)

	# Apply shade setting via clip plane color alpha
	alpha = shade == "none" ? 0 : shade == "inside" ? -0.5 : 0.5
	nv.setClipPlaneColor([1, 1, 1, alpha])
end

# ╔═╡ g6h7i8j9-d7e0-11ef-1234-0123456789ab
md"""
## Clip Plane Configurations

- **0 planes**: No clipping (full brain visible)
- **1 plane**: Single anterior clip
- **2 planes**: Anterior + posterior oblique
- **3 planes**: Right center, posterior oblique, inferior
- **4 planes**: Left, right, anterior, posterior
- **5 planes**: Left, right, anterior, posterior, inferior
- **6 planes**: All six directions
"""

# ╔═╡ Cell order:
# ╠═a1b2c3d4-d7e0-11ef-1234-0123456789ab
# ╠═b2c3d4e5-d7e0-11ef-1234-0123456789ab
# ╟─c3d4e5f6-d7e0-11ef-1234-0123456789ab
# ╠═d4e5f6g7-d7e0-11ef-1234-0123456789ab
# ╟─e4f5g6h7-d7e0-11ef-1234-0123456789ab
# ╠═f5g6h7i8-d7e0-11ef-1234-0123456789ab
# ╟─g6h7i8j9-d7e0-11ef-1234-0123456789ab
