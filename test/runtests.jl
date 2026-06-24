using Niivue
using Observables: on, Observable
using Test

@testset "Niivue.jl" begin
    @testset "Viewer creation" begin
        @test niivue() isa Niivue.NiivueViewer
        @test niivue(width=800, height=600) isa Niivue.NiivueViewer
    end

    @testset "Volume inputs" begin
        @test niivue(rand(10, 10, 5)) isa Niivue.NiivueViewer
        @test niivue(rand(10, 10, 5, 3)) isa Niivue.NiivueViewer
        @test niivue(rand(Float32, 10, 10, 5)) isa Niivue.NiivueViewer
        @test niivue(rand(Int16, 10, 10, 5)) isa Niivue.NiivueViewer

        url = "https://niivue.github.io/niivue-demo-images/mni152.nii.gz"
        @test niivue(url) isa Niivue.NiivueViewer
        @test niivue([url, url]) isa Niivue.NiivueViewer
        @test niivue(Dict(:url => url, :colormap => "gray")) isa Niivue.NiivueViewer
        @test niivue([Dict(:url => url), url]) isa Niivue.NiivueViewer
    end

    @testset "Mesh inputs" begin
        mesh = "https://niivue.github.io/niivue-demo-images/BrainMesh_ICBM152.lh.mz3"
        @test niivue(meshes=[Dict(:url => mesh)]) isa Niivue.NiivueViewer
        @test niivue(meshes=[mesh]) isa Niivue.NiivueViewer
    end

    @testset "Options and methods" begin
        @test niivue(opts=[("isColorbar", true)]) isa Niivue.NiivueViewer
        @test niivue(methods=[("setCrosshairWidth", 5)]) isa Niivue.NiivueViewer
    end

    @testset "Dynamic method calls" begin
        nv = niivue()
        nv.setCrosshairWidth(5)
        @test nv.methods[] == ["setCrosshairWidth", 5]

        nv.setSliceType(3)
        @test nv.methods[] == ["setSliceType", 3]

        nv("setGamma", 1.5)
        @test nv.methods[] == ["setGamma", 1.5]
    end

    @testset "Dynamic property setting" begin
        nv = niivue()
        nv.isColorbar = true
        @test nv.opts[] == ["isColorbar", true]

        nv.backColor = [0, 0, 0, 1]
        @test nv.opts[] == ["backColor", [0, 0, 0, 1]]
    end

    @testset "Load after creation" begin
        nv = niivue()
        url = "https://niivue.github.io/niivue-demo-images/mni152.nii.gz"

        nv.loadVolumes([url])
        @test nv.methods[][1] == "loadVolumes"
        @test nv.methods[][2][1][:url] == url

        mesh = "https://niivue.github.io/niivue-demo-images/BrainMesh_ICBM152.lh.mz3"
        nv.loadMeshes([mesh])
        @test nv.methods[][1] == "loadMeshes"
        @test nv.methods[][2][1][:url] == mesh
    end

    @testset "resolve_volumes" begin
        url = "https://example.com/file.nii.gz"
        @test Niivue.resolve_volumes(url)[1][:url] == url
        @test Niivue.resolve_volumes(Dict(:url => url))[1][:url] == url
        @test length(Niivue.resolve_volumes([url, url])) == 2

        arr = rand(10, 10, 5)
        v = Niivue.resolve_volumes(arr)[1]
        @test v[:url] isa AbstractVector{UInt8}
        @test v[:name] == "Image.nii"
    end

    @testset "resolve_meshes" begin
        mesh = "https://example.com/brain.mz3"
        @test Niivue.resolve_meshes(mesh)[1][:url] == mesh
        @test length(Niivue.resolve_meshes([mesh, mesh])) == 2
    end

    @testset "is_local_file" begin
        @test Niivue.is_local_file("file.nii.gz") == true
        @test Niivue.is_local_file("https://x.com/f.nii") == false
        @test Niivue.is_local_file("http://x.com/f.nii") == false
    end

    @testset "Event callback registration" begin
        nv = niivue()
        @test nv.events isa Observable
        @test nv.callbacks isa Dict

        # Register a callback
        received = Ref{Any}(nothing)
        on(nv, :location_change) do data
            received[] = data
        end
        @test haskey(nv.callbacks, "location_change")
        @test length(nv.callbacks["location_change"]) == 1

        # Register a second callback for the same event
        received2 = Ref{Any}(nothing)
        on(nv, :location_change) do data
            received2[] = data
        end
        @test length(nv.callbacks["location_change"]) == 2

        # Register a callback for a different event
        on(nv, :drag_release) do data end
        @test haskey(nv.callbacks, "drag_release")
        @test length(nv.callbacks["drag_release"]) == 1
    end

    @testset "Event dispatch" begin
        nv = niivue()

        received = Ref{Any}(nothing)
        on(nv, :location_change) do data
            received[] = data
        end

        # Simulate an event from JS by updating the events Observable
        nv.events[] = Dict{String, Any}("event" => "location_change", "string" => "test location")
        @test received[] !== nothing
        @test received[]["string"] == "test location"
        @test received[]["event"] == "location_change"

        # Events for unregistered types should not error
        nv.events[] = Dict{String, Any}("event" => "unknown_event")
        @test received[]["event"] == "location_change"  # still the old value

        # Test drag_release event with full structure matching JS output
        drag_data = Ref{Any}(nothing)
        on(nv, :drag_release) do data
            drag_data[] = data
        end
        nv.events[] = Dict{String, Any}(
            "event" => "drag_release",
            "tile_idx" => 1,
            "ax_cor_sag" => 2,
            "mm_length" => 42.5,
            "vox_start" => [10, 20, 30],
            "vox_end" => [40, 50, 60]
        )
        @test drag_data[]["event"] == "drag_release"
        @test drag_data[]["tile_idx"] == 1
        @test drag_data[]["ax_cor_sag"] == 2
        @test drag_data[]["mm_length"] == 42.5
        @test drag_data[]["vox_start"] == [10, 20, 30]
        @test drag_data[]["vox_end"] == [40, 50, 60]

        # Test frame_change event
        frame_data = Ref{Any}(nothing)
        on(nv, :frame_change) do data
            frame_data[] = data
        end
        nv.events[] = Dict{String, Any}("event" => "frame_change", "frame" => 5)
        @test frame_data[]["frame"] == 5
    end

    @testset "Multiple event callbacks" begin
        nv = niivue()
        count = Ref(0)
        on(nv, :image_loaded) do data
            count[] += 1
        end
        on(nv, :image_loaded) do data
            count[] += 10
        end

        nv.events[] = Dict{String, Any}("event" => "image_loaded")
        @test count[] == 11
    end

    @testset "Example files parse" begin
        for dir in ["Pluto", "vscode", "scripts"]
            path = joinpath(@__DIR__, "..", "examples", dir)
            isdir(path) || continue
            for f in filter(f -> endswith(f, ".jl"), readdir(path))
                code = read(joinpath(path, f), String)
                @test !isempty(code)
                @test try Meta.parse("begin\n$code\nend"); true catch; false end
            end
        end
    end
end