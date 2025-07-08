package.path = package.path .. ";../libraries/?.lua"
local json = require("dkjson")
local filename = "settings.json"

-- Try opening the settings file for reading
local file = io.open(filename, "r")
if not file then
    print(filename .. " doesn't exist, creating settings file.")
    file = io.open(filename, "w")
    if not file then
        error("Failed to create file: " .. filename)
    end
    file:write("{}")
    file:close()
    file = io.open(filename, "r")
    if not file then
        error("Failed to reopen file after creating it: " .. filename)
    end
end

-- Read contents
local content = file:read("*all")
file:close()

-- If file is empty, write default JSON
if not content or content == "" then
    print(filename .. " is empty, adding important elements.")
    file = io.open(filename, "w")
    if not file then
        error("Failed to open file for writing default JSON: " .. filename)
    end
    file:write("{}")
    file:close()
    content = "{}"
end

-- Decode JSON safely
local t, pos, err = json.decode(content)
if not t then
    error("Error decoding JSON: " .. (err or "unknown error"))
end

-- Add key if missing
if t["exlusion-folder"] == nil then
    t["exlusion-folder"] = "exlusion.txt"
    
    local exclusionFile = io.open("exlusion.txt", "w")
    if not exclusionFile then
        error("Failed to create exclusion file.")
    end
    exclusionFile:close()
end

-- Encode updated JSON
local updated_json = json.encode(t, { indent = true })

-- Write updated JSON back to file
file = io.open(filename, "w")
if not file then
    error("Failed to open file for writing updated JSON: " .. filename)
end

file:write(updated_json)
file:close()

print("Updated settings saved.")
