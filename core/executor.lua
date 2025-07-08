local helper = require("utils.helper")
local config = require("config")
local ytCheck = helper.ytCheck
local params = config.params
local inputURL = config.inputURL
local selection = config.selection

local output = table.concat(params, " ")
-- local result = os.execute("yt-dlp -s "..output.." "..inputURL)
local success, exit_type, exit_code = os.execute("yt-dlp -s " .. output .. " " .. inputURL)
ytCheck(success)

while true do
    print("\nDo you wish to export another " .. selection .. "?")
    print(" 1) Export again (don't change export type).")
    print(" 2) Export again (allow me to choose export type again).")
    print(" 3) Close application / no thanks.\n")

    local input = io.read()
    if input == "1" then
        print("")
        dofile("ui/urlInput")
        break
    elseif input == "2" then
        print("")
        dofile("ui/exportType")
        break
    elseif input == "3" then
        print("\nExiting program......")
        os.exit()
    else
        print("Please type 1, 2 or 3.")
    end
end