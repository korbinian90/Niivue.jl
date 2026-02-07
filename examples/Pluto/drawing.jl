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

# ╔═╡ 1a2b3c4d-c5d8-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
	Pkg.add("PlutoUI")
end

# ╔═╡ 2b3c4d5e-c5d8-11ef-1234-0123456789ab
using Niivue, PlutoUI

# ╔═╡ 3c4d5e6f-c5d8-11ef-1234-0123456789ab
md"""
# Drawing and Annotations

This example demonstrates drawing capabilities for manual annotation and ROI definition.
Based on: https://niivue.github.io/niivue/features/draw.ui.html
"""

# ╔═╡ 4d5e6f7g-c5d8-11ef-1234-0123456789ab
nv = niivue(
	[Dict(
		:url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
		:colormap => "gray",
	)],
	opts = [
		("isColorbar", true),
		("drawingEnabled", true),
	]
)

# ╔═╡ 5e6f7g8h-c5d8-11ef-1234-0123456789ab
md"""
## Drawing Tools

**Draw Mode:** $(@bind draw_mode Select([
	"false" => "Off",
	"true" => "Pen",
]))

**Pen Color:** $(@bind pen_value Select([
	"1" => "Red",
	"2" => "Green",
	"3" => "Blue",
	"4" => "Yellow",
]))

**Filled Drawing:** $(@bind filled CheckBox(default=true))
"""

# ╔═╡ 6f7g8h9i-c5d8-11ef-1234-0123456789ab
begin
	# Enable/disable drawing
	drawing_enabled = parse(Bool, draw_mode)
	nv.drawingEnabled = drawing_enabled
	
	if drawing_enabled
		# Set pen value (color)
		nv("setDrawPenValue", parse(Int, pen_value))
		
		# Set filled mode
		nv("setDrawFilled", filled)
	end
end

# ╔═╡ 7g8h9i0j-c5d8-11ef-1234-0123456789ab
md"""
## Drawing Features

Drawing capabilities include:
- **Manual annotation**: Draw regions of interest
- **Segmentation editing**: Refine automated segmentations
- **ROI definition**: Create custom regions for analysis
- **Multiple colors**: Different labels for different structures

**Note**: Drawing requires mouse interaction. Click and drag on the viewer to draw when enabled.
"""

# ╔═╡ 8h9i0j1k-c5d8-11ef-1234-0123456789ab
# Create a new drawing layer
nv("createEmptyDrawing")

# ╔═╡ Cell order:
# ╠═1a2b3c4d-c5d8-11ef-1234-0123456789ab
# ╠═2b3c4d5e-c5d8-11ef-1234-0123456789ab
# ╟─3c4d5e6f-c5d8-11ef-1234-0123456789ab
# ╠═4d5e6f7g-c5d8-11ef-1234-0123456789ab
# ╟─5e6f7g8h-c5d8-11ef-1234-0123456789ab
# ╠═6f7g8h9i-c5d8-11ef-1234-0123456789ab
# ╟─7g8h9i0j-c5d8-11ef-1234-0123456789ab
# ╠═8h9i0j1k-c5d8-11ef-1234-0123456789ab
