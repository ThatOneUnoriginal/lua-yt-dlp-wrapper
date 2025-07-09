local helper = require("utils.helper")
local config = require("config")
local ytCheck = helper.ytCheck
local params = config.params
local inputURL = config.inputURL
local selection = config.selection

print("\nRunning the yt-dlp command with the following parameters:")
print(table.concat(params, "\n"))
print("If you're downloading a long " .. selection .. ", the conversion process may take some time.")
print("Unconverted files will appear in the download folder during this process. Please avoid interacting with them, as it could disrupt the conversion.")
print("Note: Files are saved with the original upload date as their creation date, so they might not show up at the top of your Downloads folder if you're sorting by date.")

local output = table.concat(params, " ")
local success = os.execute("yt-dlp " .. output .. " " .. inputURL)
ytCheck(success)

while true do
    print("\nDo you wish to export another " .. selection .. "?")
    print(" 1) Export again (don't change export type).")
    print(" 2) Export again (allow me to choose export type again).")
    print(" 3) Close application / no thanks.\n")

    local input = io.read()
    if input == "1" then
        print("")
        dofile("ui/urlInput.lua")
        break
    elseif input == "2" then
        print("")
        dofile("ui/exportType.lua")
        break
    elseif input == "3" then
        print("\nExiting program......")
        os.exit()
    else
        print("Please type 1, 2 or 3.")
    end
end