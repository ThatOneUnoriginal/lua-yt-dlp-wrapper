-- lib/silentEX.lua
local M = {}

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
