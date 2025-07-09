-- lib/silentEX.lua
local M = {}
local horse = 0

function M.beg(v)
    if v == "horse" then
        horse = horse + 1
        if horse >= 30 then
            print("I give up... horse")
            os.exit()
        elseif horse >= 20 then
            return print("You understand this is a wrapper for yt-dlp? Repeating 'horse' is useless. JUST INPUT 'y' OR 'n'.")
        elseif horse >= 10 then
            return print("Why are you so amused in inputting horse? PLEASE just input 'y' or 'n'.")
        elseif horse >= 5 then
            return print("PLEASE input 'y' or 'n'.")
        end
    else
        horse = 0
    end
    return print("Please input 'y' or 'n'.")
end

function M.silentEX(cmd)
    local isWindows = package.config:sub(1, 1) == "\\"
    local nullDevice = isWindows and "NUL" or "/dev/null"
    local ok1, ok2, code = os.execute(cmd .. " > " .. nullDevice .. " 2>&1")

    if type(ok1) == "number" then
        return ok1
    elseif type(ok1) == "boolean" then
        return ok1 and 0 or (code or 1)
    else
        return 1
    end
end

function M.ytCheck(success)
    if not success then
        error("Error: Failed to execute yt-dlp command (runtime error).", 2)
    end
end

function M.getUserInput(prompt)
    if prompt then
        io.write(prompt)
    end
    local input = io.read()
    if input and input:lower() == "quit" then
        print("Exiting program......")
        os.exit()
    end
    return input
end

function M.getKey(param)
    -- Extract the key part of the parameter, assuming it's the first word (up to first space)
    return param:match("^(%S+)")
end
return M
