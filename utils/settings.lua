local sep = package.config:sub(1,1)
local script_path = debug.getinfo(1, "S").source:sub(2)
if sep == "\\" then
    script_path = script_path:gsub("\\", "/")
end

local cwd = io.popen(sep == "\\" and "cd" or "pwd"):read("*l") or ""
if sep == "\\" then
    cwd = cwd:gsub("\\", "/")
end

if not script_path:match("^/") and not script_path:match("^%a:/") then
    script_path = cwd .. "/" .. script_path
end

local dir = script_path:match("(.*/)")
package.path = package.path .. ";" .. dir .. "../libraries/?.lua"
local json = require("dkjson")
local filename = "settings.json"

local function createEmptySettingsFile()
    local f = io.open(filename, "w")
    if not f then error("Failed to create " .. filename) end
    f:write("{}")
    f:close()
end

local function loadSettings()
    local f = io.open(filename, "r")
    if not f then
        createEmptySettingsFile()
        f = io.open(filename, "r")
        if not f then error("Failed to open " .. filename .. " after creating") end
    end

    local content = f:read("*all")
    f:close()

    if not content or content == "" then
        createEmptySettingsFile()
        content = "{}"
    end

    local t, pos, err = json.decode(content)
    if not t then
        createEmptySettingsFile()
        t = {}
    end

    local base_dir = dir:gsub("(.*)/$", "%1")
    local parent_dir = base_dir:match("(.*)/")
    if not parent_dir or parent_dir == "" then
        parent_dir = base_dir
    end

    local exclusion_path = parent_dir .. "/exclusion.txt"

    if t["exclusion-folder"] == nil then
        t["exclusion-folder"] = exclusion_path
        local ef = io.open(t["exclusion-folder"], "w")
        if not ef then error("Failed to create " .. t["exclusion-folder"]) end
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

    local updated_json = json.encode(t, { indent = true })
    if type(updated_json) ~= "string" then
        error("Failed to encode JSON settings")
    end
    local fw = io.open(filename, "w")
    if not fw then error("Failed to open file for writing: " .. filename) end
    fw:write(updated_json)
    fw:close()

    return t
end

local t = loadSettings()

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
    if type(updated_json) ~= "string" then
        error("Failed to encode JSON settings")
    end
    local fw = io.open(filename, "w")
    if not fw then error("Failed to open file for writing: " .. filename) end
    fw:write(updated_json)
    fw:close()

end

return M
