using Niivue
using Test

@testset "Niivue.jl" begin
    @testset "Basic Creation" begin
        # Test creating empty viewer
        nv = niivue()
        @test nv isa Niivue.NiivueViewer
        @test hasfield(typeof(nv), :app)
        @test hasfield(typeof(nv), :methods)
        @test hasfield(typeof(nv), :opts)
    end
    
    @testset "Array Input" begin
        # Test with 3D array
        arr3d = rand(10, 10, 5)
        nv = niivue(arr3d)
        @test nv isa Niivue.NiivueViewer
        
        # Test with 4D array
        arr4d = rand(10, 10, 5, 3)
        nv = niivue(arr4d)
        @test nv isa Niivue.NiivueViewer
    end
    
    @testset "Volume Configuration" begin
        # Test with URL string
        url = "https://niivue.github.io/niivue-demo-images/mni152.nii.gz"
        nv = niivue(url)
        @test nv isa Niivue.NiivueViewer
        
        # Test with Dict configuration
        vol_dict = Dict(
            :url => url,
            :colormap => "gray",
            :opacity => 0.5
        )
        nv = niivue(vol_dict)
        @test nv isa Niivue.NiivueViewer
        
        # Test with multiple volumes
        volumes = [
            Dict(:url => url, :colormap => "gray"),
            Dict(:url => url, :colormap => "red", :opacity => 0.5)
        ]
        nv = niivue(volumes)
        @test nv isa Niivue.NiivueViewer
    end
    
    @testset "Options and Methods" begin
        # Test with initial options
        nv = niivue(
            opts = [("isColorbar", true), ("backColor", [1, 1, 1, 1])]
        )
        @test nv isa Niivue.NiivueViewer
        
        # Test with initial methods
        nv = niivue(
            methods = [("setCrosshairWidth", 5)]
        )
        @test nv isa Niivue.NiivueViewer
    end
    
    @testset "Canvas Size" begin
        # Test custom canvas size
        nv = niivue(width=800, height=600)
        @test nv isa Niivue.NiivueViewer
    end
    
    @testset "Helper Functions" begin
        # Test is_local_file
        @test Niivue.is_local_file("local_file.nii.gz") == true
        @test Niivue.is_local_file("https://example.com/file.nii.gz") == false
        @test Niivue.is_local_file("http://example.com/file.nii.gz") == false
        
        # Test resolve_volumes with array
        arr = rand(10, 10, 5)
        volumes = Niivue.resolve_volumes(arr)
        @test volumes isa Vector
        @test length(volumes) == 1
        @test volumes[1] isa Dict
        @test haskey(volumes[1], :url)
        @test haskey(volumes[1], :name)
        
        # Test resolve_volumes with string URL
        url = "https://example.com/file.nii.gz"
        volumes = Niivue.resolve_volumes(url)
        @test volumes isa Vector
        @test length(volumes) == 1
        @test volumes[1][:url] == url
        
        # Test resolve_volumes with Dict
        vol_dict = Dict(:url => url, :colormap => "gray")
        volumes = Niivue.resolve_volumes(vol_dict)
        @test volumes isa Vector
        @test length(volumes) == 1
        @test volumes[1][:url] == url
        @test volumes[1][:colormap] == "gray"
        
        # Test resolve_volumes with multiple volumes
        multi = [
            Dict(:url => url, :colormap => "gray"),
            url
        ]
        volumes = Niivue.resolve_volumes(multi)
        @test volumes isa Vector
        @test length(volumes) == 2
        @test all(v isa Dict for v in volumes)
    end
end

