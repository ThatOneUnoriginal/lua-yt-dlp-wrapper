local M = {}
local co = nil
local helper = require("utils.helper")
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

    -- Resume coroutine after shared params
    if coroutine.status(co) == "suspended" then
        coroutine.resume(co)
    else
        print("Coroutine not suspended or already completed.")
    end
end

return M
