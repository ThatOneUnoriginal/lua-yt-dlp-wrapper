local helper = require("utils.helper")
local config = require("config")
local params = config.params
local inputURL = config.inputURL
local getUserInput = helper.getUserInput
local ytCheck = helper.ytCheck
    
    
local subFormats = {"vtt", "srt", "ttml", "json3", "srv1", "srv2", "srv3"}
-- Only happens IF the user chooses to download subtitles into a seperate file
local function subtitleFormatting()
    local done = false

    while true do
        if done == true then
            break
        end
        print("\nHow would you like to format the subtitle file?")
        print("You can specify one or more formats separated by '/' (e.g., 'srt' or 'ass/srt/best').\n")

        print("Type 'list' if you're unsure which formats are available for a specific video.")
        print("Available formats (Type 'quit' to exit program):")

        for i, format in ipairs(subFormats) do
            io.write(format .. "\t")
        end
        print()

        local format = getUserInput():lower()

        print("")

        local success = os.execute("yt-dlp -s --write-auto-subs --sub-format " .. format .. " " .. inputURL)
        ytCheck(success)

        print("\nDo you want to continue with " .. format .. " as the subtitle file format? (y/n):")
        local confirmation = getUserInput():lower()

        while true do
            if confirmation == "y" then
                done = true
                table.insert(params, "--sub-format " .. format)
                break
            elseif confirmation == "n" then
                break
            else
                print("Please type 'y' or 'n'.")
            end
        end
    end
end

-- Download subtitles into seperate file
while true do
    print("\nDownload subtitles? (Auto, Manual, Both)")
    print("- Auto: YouTube-generated")
    print("- Manual: Added by author")
    print("- Both: Download both types")
    print("- None (Default)")
    print("Note: Subtitles are downloaded separately, not embedded. Type 'quit' to exit program:")

    local subInput = getUserInput():lower()

    if subInput == "auto" then
        print("YouTube-generated subtitles will be downloaded in a seperate file.")
        table.insert(params, "--write-auto-subs")
        subtitleFormatting()
        break
    elseif subInput == "manual" then
        print("Author-created subtitles will be downloaded in a seperate file.")
        table.insert(params, "--write-subs")
        break
    elseif subInput == "both" then
        print("YouTube-generated and Author-created will be downloaded in a seperate file.")
        table.insert(params, "--write-auto-subs")
        table.insert(params, "--write-subs")
        subtitleFormatting()
        break
    elseif subInput == "" or subInput == "none" then
        print("Subtitles will not be downloaded as a separate file.")
        break
    else
        print("Unrecognized choice. Please enter one of the following: 'auto', 'manual', 'both', or 'none'.")
    end

    while true do
    end
    dofile("core/customParameters.lua")
    break
end