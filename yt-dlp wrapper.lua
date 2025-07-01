local url = require("socket.url") -- Required dependency



-- Function to check if a URL is valid and not DRM-protected
local function urlValidation(website)
    local parsed = url.parse(website)
    if not (parsed and parsed.scheme and parsed.host) then
        return "invalid"
    end

    local handle = io.popen("yt-dlp -s " .. website .. " 2>&1")
    local result = handle:read("*a")
    handle:close()

    if result:lower():match("%f[%a]drm%f[%A]") and not result:lower():match("youtube") then
        return "drm_protected"
    elseif result:lower():match("unsupported") then
        return "unsupported"
    elseif result:lower():match("downloading 0 items") then
        return "nothing"
    end

    return "valid"
end

local function extractionParamtersSelection()
    local paramtersSelected = {}
    print("AFGDSAFGDSGFADSFFGADGAFSD")
    local userChoice
    repeat
print([[
Which Paramters Do You Want to Enable? (Section)
Type 'quit' to exit.

1. General Options
2. Network Options
3. Geo-restriction
4. Download Options
5. Filesystem Options
6. Thumbnail Options
7. Internet Shortcut Options
8. Verbosity and Simulation Options
9. Workarounds
10. Subtitle Options
11. Authentication Options
12. Post-Processing Options
13. SponsorBlock Options
14. Extractor Options
15. Preset Aliases
]])
    userChoice = io.read():lower()

    if userChoice == "quit" then
        print("Exiting Program")
        os.exit()
    end
    until userChoice
end


-- Handles video extraction if user selects option 1
local function extractionBeginning()
    print("\nYou selected: Video Extraction")
    
    -- Prompt user for a valid URL and validate it
    local allowedWebsite = false
    repeat
        print("Enter the URL of the video (type 'quit' to exit):")
        local website = io.read()
        local status = urlValidation(website)

        if website:lower() == "quit" then
            print("Quitting Program")
            os.exit()
        end
        
        if status == "valid" then
            print("Valid URL.")
            print(website)
            allowedWebsite = true
        elseif status == "invalid" then
            print("Invalid URL. Please enter a valid URL.\n")
        elseif status == "unsupported" then
            print("Invalid URL. Unfortunately this URL isn't supported by yt-dlp.")
            print("To see a list of supported urls, check https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/heads/master/supportedsites.md\n")
        elseif status == "nothing" then
            print("Invalid URL. Provided URL will download 0 items.\n")
        elseif status == "drm_protected" then
            print("Invalid URL. Requested Website is Known to Use DRM Protections.")
            print("To see a list of supported urls, check https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/heads/master/supportedsites.md\n")
        end
    until allowedWebsite

    extractionParamtersSelection()
end

local function welcome()
repeat
    print([[
Select an option:
1. Extract Video
2. Extract Audio
3. Exit
]])
    local userChoice = tonumber(io.read())
    
    if not userChoice then
        print("Invalid input. Please enter a number.\n")
    elseif userChoice < 1 or userChoice > 3 then
        print("Invalid input. Please enter a number between 1 and 3.\n")
    elseif userChoice == 3 then
        print("Exiting Program.")
        os.exit()
    elseif userChoice == 1 or userChoice == 2 then
        extractionBeginning()
    end
until userChoice == 1 or userChoice == 2
end

print("Welcome to the yt-dlp Lua Wrapper")
print("A free, local yt-dlp wrapper made in Lua.\n")
print("This is a work in progress challenge application.")
welcome()
