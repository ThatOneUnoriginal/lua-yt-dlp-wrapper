local shared = require("core.shared")
local helper = require("utils.helper")
local getUserInput = helper.getUserInput
local config = require("config")
local params = config.params
local inputURL = config.inputURL
local ytCheck = helper.ytCheck
local videoAdvanced = helper.videoAdvanced
local execution = helper.execution


local co =
    coroutine.create(function ()
        while true do
            print("\nWhat audio quality would you like to set? 0 is best, 9 is worst")
            local input = getUserInput()
            input = tonumber(input)
            local worst = 9
            local best = 0

            if not input then
                print("Please enter a number between "..best.." (best) to "..worst.." (worst).")
            elseif input < worst and input >= best then
               print("Setting audio quality levle to "..input)
               table.insert(params, "--audio-quality "..input)
               break
            elseif input > worst and input < best then
                print("Please enter a number between "..best.." (best) to "..worst.." (worst).")
            end
        end
    end
)

-- Share coroutine with shared.lua
shared.setCoroutine(co)

-- Start coroutine
coroutine.resume(co)

-- Run shared parameters (resumes the coroutine after)
shared.sharedParameters()