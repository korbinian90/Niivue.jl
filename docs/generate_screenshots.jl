# Generate gallery screenshots
#
# This script regenerates the gallery screenshots in docs/src/assets/gallery/.
# It starts a local Bonito server for each gallery example and captures a
# screenshot with a headless browser.
#
# Prerequisites:
#   pkg> add Niivue Bonito
#   npm install puppeteer        # or use any headless-browser tool
#
# Usage:
#   julia docs/generate_screenshots.jl
#
# The script reads every .jl file in examples/gallery/, spins up a Niivue
# viewer through Bonito, waits for the page to render, and saves a PNG.

using Niivue
using Bonito

const GALLERY_DIR = joinpath(@__DIR__, "..", "examples", "gallery")
const OUTPUT_DIR  = joinpath(@__DIR__, "src", "assets", "gallery")
const RENDER_WAIT_MS = 5000  # time (ms) to wait for WebGL rendering before capture

mkpath(OUTPUT_DIR)

for file in filter(f -> endswith(f, ".jl"), readdir(GALLERY_DIR))
    name = replace(file, ".jl" => "")
    outpath = joinpath(OUTPUT_DIR, "$name.png")
    println("Generating $outpath from $file ...")

    # Each gallery script creates a NiivueViewer when `include`d.
    # We capture the App, open it in a headless browser, and screenshot it.
    try
        nv = include(joinpath(GALLERY_DIR, file))
        app = nv.app

        # Open in Bonito's built-in server and screenshot with the system browser.
        # This requires a headless browser (Chromium / Puppeteer / Playwright).
        url = Bonito.url(app)
        println("  Viewer running at $url")

        # Use NodeJS + Puppeteer to capture (adjust as needed for your setup):
        js_script = """
        const puppeteer = require('puppeteer');
        (async () => {
            // --no-sandbox is required when running in containers / CI environments
            const browser = await puppeteer.launch({headless: true, args: ['--no-sandbox']});
            const page = await browser.newPage();
            await page.setViewport({width: 800, height: 600});
            await page.goto('$url', {waitUntil: 'networkidle0', timeout: 30000});
            await page.waitForTimeout($RENDER_WAIT_MS);
            await page.screenshot({path: '$outpath'});
            await browser.close();
        })();
        """
        run(`node -e $js_script`)
        println("  ✓ Saved $outpath")
    catch e
        @warn "Failed to generate screenshot for $file" exception=e
    end
end

println("\nDone! Screenshots saved to $OUTPUT_DIR")
