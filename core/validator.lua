local M = {}
local url = require('libraries.url')

function M.urlValidation(website)
    local result
    local parsed = url.parse(website)
    if not (parsed and parsed.scheme and parsed.host) then
        return "invalid"
    else
        print("URL parsing successful! Checking if URL will work with yt-dlp...")
    end

    -- Simulate yt-dlp execution using the URL
    local handle = io.popen("yt-dlp -s " .. website .. " 2>&1")
    if handle then
        result = handle:read("*a")
        handle:close()
    else
        error("Error: Failed to execute yt-dlp command.", 2)
    end
    local status
    local lower_result = result:lower()
    -- Sometimes warning(s) will appear talking about DRM protection on some clients
    -- that it uses for YouTube downloading, but they're warnings, not errors
    if lower_result:match("%f[%a]drm%f[%A]") and not lower_result:match("youtube") then
        status = "drm_protected"
    elseif lower_result:match("unsupported") then
        status = "unsupported"
    elseif lower_result:match("downloading 0 items") then
        status = "nothing"
    else
        status = "valid"
    end

    return status
end

return M