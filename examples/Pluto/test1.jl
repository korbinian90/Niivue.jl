### A Pluto.jl notebook ###
# v0.20.6

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

# ╔═╡ c590544c-877a-4c8c-bc89-0227750ca049
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
	Pkg.add("PlutoUI")
end

# ╔═╡ b47fee18-df7a-4bac-9a85-3acf0cb452d9
using Niivue, PlutoUI

# ╔═╡ 0c4f4d85-01fe-44c9-b922-f9b4e827ad6d
volumes = [
    Dict(
        :url => "https://niivue.github.io/niivue/images/mni152.nii.gz",
        :colormap => "gray",
    ),
    Dict(
        :url => "https://niivue.github.io/niivue/images/hippo.nii.gz",
        :colormap => "red",
    )
]

# ╔═╡ 849189f1-745f-47da-979d-221d0700157c
md"""
# Interactive Example
Calling niivue functions and changing niivue opts
"""

# ╔═╡ f93089e6-3ba3-49cd-b27a-f5f9a95cc17c
nv1 = niivue()

# ╔═╡ d87d7a67-211e-4390-9e7d-de5b134d1dab
nv1.loadVolumes([volumes[1]])

# ╔═╡ 96a1e670-abb4-40e2-ae53-d5d171c1c5a1
nv1.setCrosshairWidth(10)

# ╔═╡ db95b7d4-f129-4f03-914b-eeae7a94ace9
nv1.isColorbar = true

# ╔═╡ bb5f65c4-9dd0-4eb9-b588-e4ed22ae2d00
md"""
# Interactive Example with Control Panel
"""

# ╔═╡ f572804e-95e0-4a16-8034-c1a079e1249e
nv = niivue()

# ╔═╡ 1a9ecaec-5d0b-4c66-b7c7-4d26d1df5a0e
nv.loadVolumes(volumes)

# ╔═╡ ac828ffb-ce20-45e3-b78d-6f455514d3fb
# Define control panel
md"""
# Control Panel

## Crosshair
Width: $(@bind width Slider(1:10))
Color: $(@bind color Select(["red", "green", "blue"]))

## Colorbar
Colorbar: $(@bind colorbar CheckBox())

"""

# ╔═╡ 1bb6d6b2-705b-4401-8935-aceff6708224
# Link the Control Panel with niivue
begin
	nv.setCrosshairWidth(width)
	colors = Dict("red" => [1,0,0,0.5], "green" => [0,1,0,0.5], "blue" => [0,0,1,0.5])
	nv.setCrosshairColor(colors[color])
	nv.isColorbar = colorbar
end

# ╔═╡ Cell order:
# ╠═c590544c-877a-4c8c-bc89-0227750ca049
# ╠═b47fee18-df7a-4bac-9a85-3acf0cb452d9
# ╠═0c4f4d85-01fe-44c9-b922-f9b4e827ad6d
# ╟─849189f1-745f-47da-979d-221d0700157c
# ╠═f93089e6-3ba3-49cd-b27a-f5f9a95cc17c
# ╠═d87d7a67-211e-4390-9e7d-de5b134d1dab
# ╠═96a1e670-abb4-40e2-ae53-d5d171c1c5a1
# ╠═db95b7d4-f129-4f03-914b-eeae7a94ace9
# ╟─bb5f65c4-9dd0-4eb9-b588-e4ed22ae2d00
# ╠═f572804e-95e0-4a16-8034-c1a079e1249e
# ╠═1a9ecaec-5d0b-4c66-b7c7-4d26d1df5a0e
# ╠═ac828ffb-ce20-45e3-b78d-6f455514d3fb
# ╠═1bb6d6b2-705b-4401-8935-aceff6708224
