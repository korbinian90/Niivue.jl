# Event callbacks: Track crosshair position in real-time
using Niivue, Observables

nv = niivue(
    "https://niivue.github.io/niivue-demo-images/mni152.nii.gz",
    opts=[("sliceType", 4), ("isColorbar", true)],
)

# Register event callbacks
on(nv, :location_change) do data
    println("Location: ", data["string"])
end

on(nv, :drag_release) do data
    len = round(data["mm_length"]; digits=1)
    println("Drag: $(len)mm from $(data["vox_start"]) to $(data["vox_end"])")
end
