local helper = require("utils.helper")
local config = require("config")

local selection
local function urlInput()
    dofile("ui/urlInput")
end

while true do
    print("Would you like to export audio or video? Type 'quit' to exit program:")
    selection = helper.getUserInput():lower()

    if selection == "video" then
        print("Video export selected.")
        config.selection = "video"
        urlInput()
        break
    elseif selection == "audio" then
        print("Audio export selected.")
        config.selection = "audio"
        urlInput()
        break
    else
        print("\nInvalid input. Please type 'audio' or 'video'.")
    end
end