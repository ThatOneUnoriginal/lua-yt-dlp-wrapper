local M = {}
local co = nil
local helper = require("utils.helper")
-- local default = require("utils.settings")
local getUserInput = helper.getUserInput
local config = require("config")
local default = require("utils.settings")
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
            helper.beg()
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
            helper.beg()
        end
    end

    while true do
        local location = default.findDefault("download-folder")
        print("\nWhere would you like the videos to download? Enter nothing for default. Default is "..location)
        local input = getUserInput()
        if input == " " or input == location then
            print("Default selected: your media will download to "..location)
            table.insert(params, "--P "..input)
            break
        elseif input ~= location then
            print("\nYou've selected to download to a folder that is not the default ("..location..").")
            print("Would you like to make "..input.." your new default download location? (y/n):")
            local confirmation = getUserInput()
            if confirmation == "y" then
                default.saveNewDefault("download-folder", input)
                table.insert(params, "--P "..input)
                break
            elseif input == "n" then
                table.insert(params, "-P "..input)
            else
                helper.beg()
            end
        end
    end

    -- Resume coroutine after shared params
    if coroutine.status(co) == "suspended" then
        coroutine.resume(co)
    else
        print("Coroutine not suspended or already completed.")
    end
end

return M
