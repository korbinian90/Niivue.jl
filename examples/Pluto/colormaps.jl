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

# ╔═╡ 1a2b3c4d-c5d1-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
	Pkg.add("PlutoUI")
end

# ╔═╡ 2b3c4d5e-c5d1-11ef-1234-0123456789ab
using Niivue, PlutoUI

# ╔═╡ 3c4d5e6f-c5d1-11ef-1234-0123456789ab
md"""
# Colormaps Demo

This example demonstrates various colormap features and interactive controls.
Based on: https://niivue.github.io/niivue/features/colormaps.html
"""

# ╔═╡ 4d5e6f7g-c5d1-11ef-1234-0123456789ab
nv = niivue(
	[Dict(
		:url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
		:colormap => "gray",
		:opacity => 1.0,
	)],
	opts = [
		("backColor", [0.3, 0.3, 0.3, 1]),
		("isColorbar", true),
	]
)

# ╔═╡ 5e6f7g8h-c5d1-11ef-1234-0123456789ab
md"""
## Interactive Controls

**Invert Colormap:** $(@bind invert_colormap CheckBox())

**Green Crosshairs:** $(@bind green_crosshairs CheckBox())

**Wide Crosshairs:** $(@bind wide_crosshairs CheckBox())

**Gamma:** $(@bind gamma_value Slider(0.1:0.1:4.0, default=1.0, show_value=true))

**Colormap:** $(@bind selected_colormap Select(["gray", "red", "blue", "green", "redyell", "winter", "hot", "cool"]))
"""

# ╔═╡ 6f7g8h9i-c5d1-11ef-1234-0123456789ab
# Apply the interactive settings
begin
	# Set colormap
	nv("setColormap", (0, selected_colormap))
	
	# Set crosshair color
	if green_crosshairs
		nv.setCrosshairColor([0, 1, 0, 1])
	else
		nv.setCrosshairColor([1, 0, 0, 1])
	end
	
	# Set crosshair width
	if wide_crosshairs
		nv.setCrosshairWidth(3)
	else
		nv.setCrosshairWidth(1)
	end
	
	# Set gamma
	nv("setGamma", gamma_value)
	
	# Note: colormap invert would require volume-level access
	# This can be added when volume property access is implemented
end

# ╔═╡ 7g8h9i0j-c5d1-11ef-1234-0123456789ab
md"""
## Available Colormaps

The viewer supports many built-in colormaps including:
- Grayscale: `gray`
- Thermal: `hot`, `warm`, `winter`, `cool`
- Rainbow: `jet`
- Medical: `red`, `green`, `blue`, `redyell`
- And many more!
"""

# ╔═╡ Cell order:
# ╠═1a2b3c4d-c5d1-11ef-1234-0123456789ab
# ╠═2b3c4d5e-c5d1-11ef-1234-0123456789ab
# ╟─3c4d5e6f-c5d1-11ef-1234-0123456789ab
# ╠═4d5e6f7g-c5d1-11ef-1234-0123456789ab
# ╟─5e6f7g8h-c5d1-11ef-1234-0123456789ab
# ╠═6f7g8h9i-c5d1-11ef-1234-0123456789ab
# ╟─7g8h9i0j-c5d1-11ef-1234-0123456789ab
