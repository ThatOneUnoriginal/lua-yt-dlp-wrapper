package.path = package.path .. ";../libraries/?.lua"
local json = require("dkjson")
local filename = "settings.json"

local function createEmptySettingsFile()
    local f = io.open(filename, "w")
    if not f then error("Failed to create " .. filename) end
    f:write("{}")
    f:close()
end

local function loadSettings()
    -- Try open file; if missing create it
    local f = io.open(filename, "r")
    if not f then
        print(filename .. " doesn't exist, creating new settings file.")
        createEmptySettingsFile()
        f = io.open(filename, "r")
        if not f then error("Failed to open " .. filename .. " after creating") end
    end

    local content = f:read("*all")
    f:close()

    -- If empty or nil, recreate file and reload content
    if not content or content == "" then
        print(filename .. " is empty, resetting.")
        createEmptySettingsFile()
        content = "{}"
    end

    -- Decode JSON safely, try recover if invalid JSON
    local t, pos, err = json.decode(content)
    if not t then
        print("Warning: corrupted JSON in " .. filename .. ", resetting file.")
        createEmptySettingsFile()
        t = {}
    end

    -- Defaults
    if t["exclusion-folder"] == nil then
        t["exclusion-folder"] = "exclusion.txt"
        local ef = io.open("exclusion.txt", "w")
        if not ef then error("Failed to create exclusion.txt") end
        ef:close()
    end

    local function getDownloadsFolder()
        local home
        local sep = package.config:sub(1,1)
        local os_name

        if sep == '\\' then os_name = "windows" else os_name = "unix" end

        if os_name == "windows" then
            home = os.getenv("USERPROFILE")
            if home then return home .. sep .. "Downloads" end
        else
            home = os.getenv("HOME")
            if home then return home .. sep .. "Downloads" end
        end

        return nil
    end

    if t["download-folder"] == nil then
        t["download-folder"] = getDownloadsFolder()
    end

    -- Save updated settings
    local updated_json = json.encode(t, { indent = true })
    local fw = io.open(filename, "w")
    if not fw then error("Failed to open file for writing: " .. filename) end
    fw:write(updated_json)
    fw:close()

    print("Settings loaded and saved.")

    return t
end

-- Call it once to initialize/load settings
local t = loadSettings()

-- Module and function to retrieve values
local M = {}
function M.findDefault(key)
    if not key or type(key) ~= "string" then
        error("findDefault expects a string key")
    end
    return t[key]
end

function M.saveNewDefault(key, value)
    if not key or type(key) ~= "string" then
        error("saveNewDefault expects a string key")
    end
    t[key] = value
    local updated_json = json.encode(t, { indent = true })
    local fw = io.open(filename, "w")
    if not fw then error("Failed to open file for writing: " .. filename) end
    fw:write(updated_json)
    fw:close()
end

return M
