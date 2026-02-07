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

# ╔═╡ 1a2b3c4d-c5d6-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
	Pkg.add("PlutoUI")
end

# ╔═╡ 2b3c4d5e-c5d6-11ef-1234-0123456789ab
using Niivue, PlutoUI

# ╔═╡ 3c4d5e6f-c5d6-11ef-1234-0123456789ab
md"""
# Custom Layouts

This example demonstrates different viewport layouts for simultaneous multi-view display.
Based on: https://niivue.com/demos/features/layout.html
"""

# ╔═╡ 4d5e6f7g-c5d6-11ef-1234-0123456789ab
nv = niivue(
	[Dict(
		:url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
		:colormap => "gray",
	)],
	opts = [
		("multiplanarLayout", 0),  # 0=Auto, 1=Column, 2=Grid, 3=Row
		("isColorbar", true),
	]
)

# ╔═╡ 5e6f7g8h-c5d6-11ef-1234-0123456789ab
md"""
## Layout Controls

**Layout Mode:** $(@bind layout_mode Select([
	"0" => "Auto (Default)",
	"1" => "Column Layout",
	"2" => "Grid Layout",
	"3" => "Row Layout"
]))

**Slice Type:** $(@bind slice_type Select([
	"4" => "Multiplanar",
	"0" => "Axial",
	"1" => "Coronal",
	"2" => "Sagittal",
	"3" => "3D Render"
]))
"""

# ╔═╡ 6f7g8h9i-c5d6-11ef-1234-0123456789ab
begin
	# Apply layout settings
	nv("setMultiplanarLayout", parse(Int, layout_mode))
	nv("setSliceType", parse(Int, slice_type))
end

# ╔═╡ 7g8h9i0j-c5d6-11ef-1234-0123456789ab
md"""
## Layout Modes

- **Auto**: Automatically arranges views based on available space
- **Column**: Stacks views vertically
- **Grid**: Arranges views in a grid pattern
- **Row**: Places views horizontally

Combined with multiplanar viewing, this allows flexible workspace organization!
"""

# ╔═╡ Cell order:
# ╠═1a2b3c4d-c5d6-11ef-1234-0123456789ab
# ╠═2b3c4d5e-c5d6-11ef-1234-0123456789ab
# ╟─3c4d5e6f-c5d6-11ef-1234-0123456789ab
# ╠═4d5e6f7g-c5d6-11ef-1234-0123456789ab
# ╟─5e6f7g8h-c5d6-11ef-1234-0123456789ab
# ╠═6f7g8h9i-c5d6-11ef-1234-0123456789ab
# ╟─7g8h9i0j-c5d6-11ef-1234-0123456789ab
