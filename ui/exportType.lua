local input
local function urlInput()
    dofile("ui/urlInput.lua")
end

while true do
    print("Would you like to export audio or video? Type 'quit' to exit program:")
    input = helper.getUserInput():lower()

    if input == "video" then
        print("Video export selected.")
        selection = "video"
        urlInput()
        break
    elseif input == "audio" then
        print("Audio export selected.")
        selection = "audio"
        urlInput()
        break
    else
        print("\nInvalid input. Please type 'audio' or 'video'.")
    end
end