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

# ╔═╡ 1a2b3c4d-c5d3-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
	Pkg.add("PlutoUI")
end

# ╔═╡ 2b3c4d5e-c5d3-11ef-1234-0123456789ab
using Niivue, PlutoUI

# ╔═╡ 3c4d5e6f-c5d3-11ef-1234-0123456789ab
md"""
# 4D Time Series Visualization

This example demonstrates viewing 4D neuroimaging data (3D volumes over time).
Based on: https://niivue.github.io/niivue/features/example_4d.html
"""

# ╔═╡ 4d5e6f7g-c5d3-11ef-1234-0123456789ab
nv = niivue(
	[Dict(
		:url => "https://niivue.github.io/niivue-demo-images/pcasl.nii.gz",
		:colormap => "warm",
	)],
	opts = [
		("isColorbar", true),
	]
)

# ╔═╡ 5e6f7g8h-c5d3-11ef-1234-0123456789ab
md"""
## Time Series Controls

**Volume (time point):** $(@bind volume_idx Slider(0:79, default=0, show_value=true))
"""

# ╔═╡ 6f7g8h9i-c5d3-11ef-1234-0123456789ab
# Navigate through time series
nv("setFrame4D", (0, volume_idx))

# ╔═╡ 7g8h9i0j-c5d3-11ef-1234-0123456789ab
md"""
## 4D Features

Niivue.jl supports:
- Loading 4D NIfTI files (3D + time)
- Interactive volume/timepoint navigation
- Frame-by-frame playback
- Statistical maps over time
- BOLD fMRI visualization
"""

# ╔═╡ Cell order:
# ╠═1a2b3c4d-c5d3-11ef-1234-0123456789ab
# ╠═2b3c4d5e-c5d3-11ef-1234-0123456789ab
# ╟─3c4d5e6f-c5d3-11ef-1234-0123456789ab
# ╠═4d5e6f7g-c5d3-11ef-1234-0123456789ab
# ╟─5e6f7g8h-c5d3-11ef-1234-0123456789ab
# ╠═6f7g8h9i-c5d3-11ef-1234-0123456789ab
# ╟─7g8h9i0j-c5d3-11ef-1234-0123456789ab
