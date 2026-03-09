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

# ╔═╡ a1b2c3d4-d8e0-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
	Pkg.add("PlutoUI")
end

# ╔═╡ b2c3d4e5-d8e0-11ef-1234-0123456789ab
using Niivue, Observables, PlutoUI

# ╔═╡ c3d4e5f6-d8e0-11ef-1234-0123456789ab
md"""
# Drag Measurement Callback

This example demonstrates **bidirectional drag callbacks**. Drag on the image
in measurement mode to measure distances in voxel coordinates.

Based on: [ipyniivue dragcallback.ipynb](https://github.com/niivue/ipyniivue/blob/main/examples/dragcallback.ipynb)
"""

# ╔═╡ d4e5f6g7-d8e0-11ef-1234-0123456789ab
nv = niivue(
	[Dict(
		:url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
		:colormap => "gray",
		:opacity => 1.0,
	)],
	opts = [
		("sliceType", 4),
		("show3Dcrosshair", true),
		("backColor", [1, 1, 1, 1]),
		("isRadiologicalConvention", false),
	],
)

# ╔═╡ e4f5g6h7-d8e0-11ef-1234-0123456789ab
md"""
## Controls

**Drag Mode:** $(@bind drag_mode Select([
	"Contrast" => 1,
	"Measurement" => 2,
	"Pan/Zoom" => 3,
	"Slicer 3D" => 4,
], default=2))
"""

# ╔═╡ f5g6h7i8-d8e0-11ef-1234-0123456789ab
# Apply drag mode (NiiVue drag modes: 1=contrast, 2=measurement, 3=pan, 4=slicer3D)
nv.dragMode = drag_mode

# ╔═╡ g6h7i8j9-d8e0-11ef-1234-0123456789ab
md"""
## Event Output

Drag on the image to see measurement results. The `:location_change` and
`:drag_release` events send data back from JavaScript to Julia.
"""

# ╔═╡ h7i8j9k0-d8e0-11ef-1234-0123456789ab
# Track location changes
begin
	location = Observable("Move crosshair to see location")
	on(nv, :location_change) do data
		location[] = get(data, "string", "")
	end
	location
end

# ╔═╡ i8j9k0l1-d8e0-11ef-1234-0123456789ab
# Track drag releases
begin
	drag_info = Observable("Drag on the image (in measurement mode) to measure")
	on(nv, :drag_release) do data
		tile = get(data, "tile_idx", nothing)
		if tile === nothing
			drag_info[] = "Invalid drag"
		else
			len = round(get(data, "mm_length", 0); digits=1)
			vs = get(data, "vox_start", [0, 0, 0])
			ve = get(data, "vox_end", [0, 0, 0])
			drag_info[] = "Tile: $tile  Length: $(len)mm  Start: $vs → End: $ve"
		end
	end
	drag_info
end

# ╔═╡ j9k0l1m2-d8e0-11ef-1234-0123456789ab
md"""
## Drag Modes

| Mode | Value | Description |
|------|-------|-------------|
| Contrast | 1 | Adjust window/level by dragging |
| Measurement | 2 | Measure distances between two points |
| Pan/Zoom | 3 | Pan and zoom the view |
| Slicer 3D | 4 | Rotate the 3D rendering |
"""

# ╔═╡ Cell order:
# ╠═a1b2c3d4-d8e0-11ef-1234-0123456789ab
# ╠═b2c3d4e5-d8e0-11ef-1234-0123456789ab
# ╟─c3d4e5f6-d8e0-11ef-1234-0123456789ab
# ╠═d4e5f6g7-d8e0-11ef-1234-0123456789ab
# ╟─e4f5g6h7-d8e0-11ef-1234-0123456789ab
# ╠═f5g6h7i8-d8e0-11ef-1234-0123456789ab
# ╟─g6h7i8j9-d8e0-11ef-1234-0123456789ab
# ╠═h7i8j9k0-d8e0-11ef-1234-0123456789ab
# ╠═i8j9k0l1-d8e0-11ef-1234-0123456789ab
# ╟─j9k0l1m2-d8e0-11ef-1234-0123456789ab
