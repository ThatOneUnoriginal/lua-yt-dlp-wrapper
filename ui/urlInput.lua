local input
local inputCheck = require('core.validator')

while true do
    print("\nEnter the URL that you're wanting to export (type 'quit' to exit):")
    input = io.read()

    if input:lower() == "quit" then
        print("Exiting program....")
    else
        print("Validating URL, this may take a couple minutes...")
    end

    local status = inputCheck.urlValidation(input)

    if status == "valid" then
        -- URLs are invalid for reasons specififed in the urlValidation
        print("Valid URL.")
        inputURL = input 
        print(inputURL)
        if config.keepParams == "true" then
            dofile('core/executor.lua')
        else
            dofile('ui/formatType.lua')
        end
        break
    elseif status == "invalid" then
        print("Invalid URL. Please enter a valid URL.")
    elseif status == "unsupported" then
        print("Invalid URL. Unfortunately this URL isn't supported by yt-dlp.")
        print(
            "To see a list of supported urls, check https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/heads/master/supportedsites.md"
        )
    elseif status == "nothing" then
        print("Invalid URL. Provided URL will download 0 items.")
    elseif status == "drm_protected" then
        print("Invalid URL. Requested Website is Known to Use DRM Protections.")
        print(
            "To see a list of supported urls, check https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/heads/master/supportedsites.md"
        )
    end
end
