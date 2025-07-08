local M = {}
local co = nil
local helper = require("utils.helper")
local default = require("settings")
local getUserInput = helper.getUserInput
local config = require("config")
local params = config.params

-- Store the coroutine reference
function M.setCoroutine(coroutineObj)
    co = coroutineObj
end

-- Shared options that happen between video tasks
function M.sharedParameters()
    -- Embed metadata
    while true do
        print("\nWould you like to embed metadata? (y/n):")
        local input = getUserInput():lower()

        if input == "y" then
            table.insert(params, "--embed-metadata")
            break
        elseif input == "n" then
            break
        else
            print("Please type 'y' or 'n'.")
        end
    end

    -- Embed thumbnail
    while true do
        print("\nWould you like to embed thumbnail? (y/n):")
        local input = getUserInput():lower()

        if input == "y" then
            table.insert(params, "--embed-thumbnail")
            break
        elseif input == "n" then
            break
        else
            print("Please type 'y' or 'n'.")
        end
    end

   --[[ while true do
        print("\nWhere would you like the videos to download? Enter nothing for default. Default is "..default.download_folder)
        local input = getUserInput()
        if input == "" or input == default.downloads_folder then
            print("Default selected: your media will download to "..default.download_folder)
            table.insert(params, "--P "..input)
            break
        elseif input ~= default.downloads_folder then
            while true do
                print("You've selected to download to a folder that is not the default ("..default.downloads_folder..").")
                print("Would you like to make "..input.." your new default download location? (y/n):")
            
                local input = getUserInput()
                if input == "y" then
                    default.downloads_folder = input
                    table.insert(params, "--P "..input)
                    break
                elseif input == "n" then
                    table.insert(params, "--P "..input)
                    break
                end
            end
        end
    end ]]

    -- Resume coroutine after shared params
    if coroutine.status(co) == "suspended" then
        coroutine.resume(co)
    else
        print("Coroutine not suspended or already completed.")
    end
end

return M
