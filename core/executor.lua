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
    print(" 1) Export again (keep export type, reselect parameters).")
    print(" 2) Export again (keep export type, keep parameters).")
    print(" 3) Export again (reselect export type).")
    print(" 4) Close application / no thanks.\n")

    local input = io.read()
    if input == "1" then
        print("")
        dofile("ui/urlInput.lua")
        keepParams = false
        break
    elseif input == "2" then
        keepParams = true
        dofile("ui/urlInput.lua")
    elseif input == "3" then
        print("")
        dofile("ui/exportType.lua")
        break
    elseif input == "4" then
        print("\nExiting program......")
        os.exit()
    else
        print("Please type 1, 2, 3, or 4.")
    end
end