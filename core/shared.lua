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
            if config.selection == "audio" then
                print("Note, if you're downloading a playlist or album / mixtape / ep the tracklisting MAY not be saved as metadata.")
            end 
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
        print("\nWhere would you like the media to download? Enter nothing for default. Default is: " .. location)

        local input = getUserInput()

        -- Normalize input by trimming whitespace
        input = input:match("^%s*(.-)%s*$")

        if input == "" then
            print("Default selected: your media will download to " .. location)
            table.insert(params, '-P "' .. location .. '"')
            break
        elseif input == location then
            print("You entered the default folder. Proceeding with default location.")
            table.insert(params, '-P "' .. location .. '"')
            break
        else
            print("\nYou've selected to download to a folder that is not the default (" .. location .. ").")
            print("Would you like to make \"" .. input .. "\" your new default download location? (y/n):")

            local confirmation = getUserInput()

            if confirmation == "y" then
                default.saveNewDefault("download-folder", input)
                table.insert(params, '-P "' .. input .. '"')
                break
            elseif confirmation == "n" then
                table.insert(params, '-P "' .. input .. '"')
                
                break
            else
                helper.beg()  -- This seems like a custom function for re-prompting or showing help
            end
        end
    end


    while true do
        local location = default.findDefault("exclusion-folder")
        print("\nWhere would you like the exclusion folder to be? Enter nothing for default.")
        print("Default is: " .. location)
        print("Note: An exclusion folder helps yt-dlp skip files it has already downloaded.")
        print("Type 'n' to skip using one, or 'y' to use the default exclusion folder.")

        local input = getUserInput()
        input = input:match("^%s*(.-)%s*$")  -- trim whitespace

        if input == "y" or input == "" then
            print("Default selected: using exclusion file at " .. location)
            table.insert(params, '--download-archive "' .. location .. '"')
            break

        elseif input == "n" then
            print("Exclusion file will not be used. Media will not be skipped based on past downloads.")
            break

        else
            while true do
                print("\nYou selected a non-default location: " .. input)
                print("Warning: New exclusion files won't include entries from the default.")
                print("You must manually copy them if needed.")
                print("Would you like to set this as your new default exclusion folder? (y/n):")

                local confirmation = getUserInput()
                confirmation = confirmation:match("^%s*(.-)%s*$")  -- trim 
                if confirmation == "y" then
                    default.saveNewDefault("exclusion-folder", input)
                    table.insert(params, '--download-archive "' .. input .. '"')
                    break
                elseif confirmation == "n" then
                    table.insert(params, '--download-archive "' .. input .. '"')
                    break
                else
                    helper.beg()
                end
            end
            break  -- Exit outer loop after handling custom input
        end
    end


    -- Resume coroutine after shared params
    if co and coroutine.status(co) == "suspended" then
        coroutine.resume(co)
    else
            
    end
end

return M
