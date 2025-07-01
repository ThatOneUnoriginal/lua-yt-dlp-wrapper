local url = require("socket.url") -- Required dependency
local paramtersSelected = {}

local function parameterSelection(sectionChoice)



    return paramtersSelected
end

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

-- This is where the user will select the parameters for yt-dlp
local function extractionParamtersCategory(userChoice)
    local sectionChoice

    if userChoice == 2 then
        table.insert(paramtersSelected, "-x")
    end


    repeat
-- This presents the users with the categories as done on the yt-dlp repo README page
print([[
Which Paramters Do You Want to Enable? (Section)
Type 'quit' to exit.

1. General Options
2. Network Options
3. Geo-restriction
4. Video Selection
5. Download Options
6. Filesystem Options
7. Thumbnail Options
8. Internet Shortcut Options
9. Verbosity and Simulation Options
10. Workarounds
11. Video Format Options
12. Subtitle Options
13. Authentication Options
14. Post-Processing Options
15. SponsorBlock Options
16. Extractor Options
17. Preset Aliases
18. Shows Currently Selected Pramaters
19. Quit
]])
    sectionChoice = tonumber(io.read())

    -- User Quits Application
    if sectionChoice == 19 then
        print("Exiting Program")
        os.exit()
    elseif sectionChoice == 18 then
        print("These are the parameters that have been selected:")
        for _, param in ipairs(paramtersSelected) do
            print(param.."\n")
        end
    end
    -- User Selects a Category
    if sectionChoice > 0 and sectionChoice < 18 then
        parameterSelection(sectionChoice)
    elseif sectionChoice == 18 then
        sectionChoice = nil
    else 
        print("Please input a number between 1 and 18\n")
    end
    until sectionChoice and sectionChoice > 0 and sectionChoice < 18
   
end

-- This handles asking the user for the URL that'll be used
local function extractionBeginning(userChoice)
    print("\nYou selected: Video Extraction")
    
    -- This will prompt the user for the URL
    local allowedWebsite = false
    repeat
        print("Enter the URL of the video (type 'quit' to exit):")
        local website = io.read()

        -- This will be used to validate the URL after input is given
        local status = urlValidation(website)

        if website:lower() == "quit" then
            print("Quitting Program")
            os.exit()
        end
        
        -- This indicates the URL is valid, no issues are present
        if status == "valid" then
            print("Valid URL.")
            print(website)
            allowedWebsite = true
        -- This indicates the URL parsing FAILED, not yt-dlp simulating URL download
        elseif status == "invalid" then
            print("Invalid URL. Please enter a valid URL.\n")
        -- This indicates yt-dlp will FAIL with provided URL. The website isn't supported by yt-dlp.
        elseif status == "unsupported" then
            print("Invalid URL. Unfortunately this URL isn't supported by yt-dlp.")
            print("To see a list of supported urls, check https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/heads/master/supportedsites.md\n")
        -- This indicates yt-dlp will NOT download anything with provided URL.
        -- URL works and is supported by yt-dlp
        elseif status == "nothing" then
            print("Invalid URL. Provided URL will download 0 items.\n")
        -- This indicates yt-dlp will FAIL with provided URL. The content is DRM protected.
        elseif status == "drm_protected" then
            print("Invalid URL. Requested Website is Known to Use DRM Protections.")
            print("To see a list of supported urls, check https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/heads/master/supportedsites.md\n")
        end
    until allowedWebsite

    extractionParamtersCategory(userChoice)
end

-- This is the first thing users are prompted with
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
        extractionBeginning(userChoice)
    end
until userChoice == 1 or userChoice == 2

end

print("Welcome to the yt-dlp Lua Wrapper")
print("A free, local yt-dlp wrapper made in Lua.")
print("This is a work in progress challenge application.\n")
local userChoice = welcome()
