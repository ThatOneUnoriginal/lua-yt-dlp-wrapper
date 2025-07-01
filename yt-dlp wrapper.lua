local url = require("socket.url") -- Required dependency
local parametersSelected = {}
local extractionParametersCategory

local function parameterSelection(sectionChoice)
    local file = io.open("data/command" .. sectionChoice .. ".md", "r")
    if not file then
        print(
            "Failed to read 'command" ..
                sectionChoice ..
                    ".md'.\n" .. "Please make sure the file exists in the 'data' subfolder and is named correctly."
        )
        return -- Exit the function if file is missing
    end

    local content = file:read("*a")
    file:close()
    print("\n" .. content .. "\n")

    repeat
        print("Input which parameters you want to use from this list.")
        print("You can input multiple parameters at once.")
        print("Type 'exit' to return to category selecton.\nType'quit' to exit the program.")
        local parameterInput = io.read()

        if parameterInput:lower() == "quit" then
            print("Exiting Program")
            os.exit()
        elseif parameterInput:lower() == "exit" then
            extractionParametersCategory()
        else
            for param in parameterInput:gmatch("[^,]+") do
                local trimmedParam = param:match("^%s*(.-)%s*$")
                table.insert(parametersSelected, trimmedParam)
            end
        end
    until false
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
function extractionParametersCategory(userChoice)
    local sectionChoice

    if userChoice == 2 then
        table.insert(parametersSelected, "-x")
    end

    repeat
        print(
            [[
Which Paramters Do You Want to Enable? (Section)
Type 'quit' to exit.
Type 'find --command' to search for a specific parameter

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
]]
        )

        local input = io.read()
        local skipRest = false
        
        -- Handle find command
        if input:lower():match("^find%s+") then
            local searchTerm = input:match("^find%s+(.+)$")
            if searchTerm then
                print("\nSearching for: "..searchTerm)
                local found = false
                local categoryNames = {
                    "1. General Options",
                    "2. Network Options",
                    "3. Geo-restriction",
                    "4. Video Selection",
                    "5. Download Options",
                    "6. Filesystem Options",
                    "7. Thumbnail Options",
                    "8. Internet Shortcut Options",
                    "9. Verbosity and Simulation Options",
                    "10. Workarounds",
                    "11. Video Format Options",
                    "12. Subtitle Options",
                    "13. Authentication Options",
                    "14. Post-Processing Options",
                    "15. SponsorBlock Options",
                    "16. Extractor Options",
                    "17. Preset Aliases"
                }
                
                -- First try exact match with --
                for i = 1, 17 do
                    local file = io.open("data/command"..i..".md", "r")
                    if file then
                        for line in file:lines() do
                            if line:find(searchTerm, 1, true) then
                                found = true
                                print("Found in: "..categoryNames[i])
                                break
                            end
                        end
                        file:close()
                    end
                end
                
                -- If not found, try without --
                if not found and searchTerm:match("^%-%-") then
                    local cleanTerm = searchTerm:gsub("^%-%-", "")
                    for i = 1, 17 do
                        local file = io.open("data/command"..i..".md", "r")
                        if file then
                            for line in file:lines() do
                                if line:match("%f[%w-]"..cleanTerm.."%f[^%w-]") then
                                    found = true
                                    print("Found in: "..categoryNames[i])
                                    break
                                end
                            end
                            file:close()
                        end
                    end
                end

                if not found then
                    print("Parameter not found in any category")
                end
                print()
            end
            skipRest = true
        end

        if not skipRest then
            if input:lower() == "quit" then
                print("Exiting Program")
                os.exit()
            end

            sectionChoice = tonumber(input)

            if sectionChoice == nil then
                print("Invalid input, please enter a number between 1 and 19 or use the find command.\n")
            else
                if sectionChoice == 19 then
                    print("Exiting Program")
                    os.exit()
                elseif sectionChoice == 18 then
                    print("These are the parameters that have been selected:")
                    for _, param in ipairs(parametersSelected) do
                        print(param)
                    end
                    print()
                elseif sectionChoice > 0 and sectionChoice < 18 then
                    parameterSelection(sectionChoice)
                else
                    print("Please input a number between 1 and 19\n")
                end
            end
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

        -- Status handling
        if status == "valid" then
            print("Valid URL.")
            print(website)
            allowedWebsite = true
        elseif status == "invalid" then
            print("Invalid URL. Please enter a valid URL.\n")
        elseif status == "unsupported" then
            print("Invalid URL. Unfortunately this URL isn't supported by yt-dlp.")
            print(
                "To see a list of supported urls, check https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/heads/master/supportedsites.md\n"
            )
        elseif status == "nothing" then
            print("Invalid URL. Provided URL will download 0 items.\n")
        elseif status == "drm_protected" then
            print("Invalid URL. Requested Website is Known to Use DRM Protections.")
            print(
                "To see a list of supported urls, check https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/heads/master/supportedsites.md\n"
            )
        end
    until allowedWebsite

    extractionParametersCategory(userChoice)
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

-- Main program execution
print("Welcome to the yt-dlp Lua Wrapper")
print("A free, local yt-dlp wrapper made in Lua.")
print("This is a work in progress challenge application.\n")

local userChoice = welcome()
