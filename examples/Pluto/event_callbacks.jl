### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ a1b2c3d4-d6e0-11ef-1234-0123456789ab
begin
	import Pkg
	Pkg.develop(url="https://github.com/korbinian90/Niivue.jl")
end

# ╔═╡ b2c3d4e5-d6e0-11ef-1234-0123456789ab
using Niivue, Observables

# ╔═╡ c3d4e5f6-d6e0-11ef-1234-0123456789ab
md"""
# Bidirectional Event Callbacks

This example demonstrates **bidirectional communication** between Julia and the
NiiVue viewer. When the crosshair moves in the viewer, the `on_location_change`
event fires and sends the position back to Julia.

Based on: [ipyniivue on\_event.ipynb](https://github.com/niivue/ipyniivue/blob/main/examples/on_event.ipynb)
"""

# ╔═╡ d4e5f6g7-d6e0-11ef-1234-0123456789ab
nv = niivue(
	[Dict(
		:url => "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
		:colormap => "gray",
		:opacity => 1.0,
	),
	Dict(
		:url => "https://niivue.github.io/niivue-demo-images/hippo.nii.gz",
		:colormap => "red",
		:opacity => 1.0,
	)],
	opts = [
		("sliceType", 4),
		("isColorbar", true),
	]
)

# ╔═╡ e5f6g7h8-d6e0-11ef-1234-0123456789ab
md"""
## Location Tracking

Move the crosshair in the viewer above. The current position will be displayed
below, updated in real-time via the `on(nv, :location_change)` callback.
"""

# ╔═╡ f6g7h8i9-d6e0-11ef-1234-0123456789ab
# Register a callback to track crosshair location
begin
	location_text = Observable("Click on the viewer to see crosshair position")
	on(nv, :location_change) do data
		location_text[] = get(data, "string", "")
	end
	location_text
end

# ╔═╡ g7h8i9j0-d6e0-11ef-1234-0123456789ab
md"""
## How It Works

The `on` function registers a Julia callback for NiiVue events.
When the user interacts with the viewer, the JavaScript NiiVue instance emits
events that are sent back to Julia via Bonito's bidirectional Observable system.

### Available Events

| Event | Description |
|-------|-------------|
| `:location_change` | Crosshair position changed |
| `:drag_release` | Mouse drag completed |
| `:image_loaded` | Image finished loading |
| `:frame_change` | 4D volume frame changed |
| `:clip_plane_change` | Clip plane modified |
| `:intensity_change` | Intensity/contrast changed |
| `:volume_updated` | Volume data updated |
"""

# ╔═╡ Cell order:
# ╠═a1b2c3d4-d6e0-11ef-1234-0123456789ab
# ╠═b2c3d4e5-d6e0-11ef-1234-0123456789ab
# ╟─c3d4e5f6-d6e0-11ef-1234-0123456789ab
# ╠═d4e5f6g7-d6e0-11ef-1234-0123456789ab
# ╟─e5f6g7h8-d6e0-11ef-1234-0123456789ab
# ╠═f6g7h8i9-d6e0-11ef-1234-0123456789ab
# ╟─g7h8i9j0-d6e0-11ef-1234-0123456789ab
