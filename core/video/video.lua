-- Create coroutine
local co =
    coroutine.create(
    function()
        local areSubs = false

        -- Ask to embed subtitles
        while true do
            print("\nWould you like to embed subtitles? (y/n):")
            local input = getUserInput():lower()

            if input == "y" then
                table.insert(params, "--embed-subs")
                areSubs = true
                break
            elseif input == "n" then
                print("Subtitles will not be embedded into the video.")
                break
            else
                helper.beg(input)
            end
        end

        local done = false

        local function askLanguage()
            while true do
                if done then
                    break
                end

                print("\nSelect subtitle language (type 'list' to view available options):")
                local input = getUserInput():lower()

                if input == "list" then
                    local result
                    -- Loop will repeat without setting done = true
                    print("")
                    local command = 'yt-dlp --list-subs "' .. inputURL .. '"'
                    local success = io.popen(command)
                    ytCheck(success)
                    if success then
                        result = success:read("*a")
                        print(result)
                        success:close()
                    end
                    local lower_result = result:lower()
                    if lower_result:match("has no subtitles") then
                        print("This video has been reported to have no avialable subtitles.")
                        print("Embed subtitles has been overwriten to no.")
                        table.remove(params)
                        break
                    end
                else
                    while true do
                        print("\nConfirm selecting " .. input .. " as the subtitle language? (y/n):")
                        local confirmation = getUserInput():lower()

                        if confirmation == "y" then
                            done = true
                            print(input .. " has been set as the subtitle language.")
                            table.insert(params, "--sub-lang "..input)
                            break
                        elseif confirmation == "n" then
                            break
                        else
                            helper.beg(confirmation)
                        end
                    end
                end
            end
        end

        -- Ask for subtitle language
        if areSubs == true then
            askLanguage()
        end

        -- Ask about chapters
        while true do
            print("\nWould you like to embed video chapters? (y/n):")
            local input = getUserInput():lower()

            if input == "y" then
                table.insert(params, "--embed-chapters")
                break
            elseif input == "n" then
                break
            else
                helper.beg(input)
            end
        end

        -- Pause here and resume in sharedParameters
        coroutine.yield()

        -- Advanced options
        while true do
            print("\nDo you want to choose more advanced options? (y/n):")
            local input = getUserInput():lower()

            if input == "y" then
                print("Moving to advanced video parameter selection.")
                dofile("core/audio/advancedAudio.lua")
                break
            elseif input == "n" then
                print("Skipping advanced video parameter selection.\n")
                dofile("core/executor.lua")
                break
            else
                helper.beg(input)
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

dofile("core/video/advancedVideo.lua")
