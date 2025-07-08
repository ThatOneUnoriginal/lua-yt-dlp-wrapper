local helper = require("utils.helper")
local config = require("config")

print("\nChecking to see if yt-dlp is accessible...")

if helper.silentEX("yt-dlp --version") == 1 then
    error("yt-dlp is not installed or not accessible in PATH.", 2)
else
    print("yt-dlp was accessed successfully!\n")
end

print("Checking to see if ffmpeg is accesisble... ffmpeg is not necessary for wrapper usage...")

if helper.silentEX("ffmpeg --version") == 1 then
    print("ffmpeg / ffprobe is not installed or not accessible in PATH.")
    print("Parameters like --audio-format cannot work without ffmpeg.\n")
else
    print("ffmpeg was accessed successfully!\n")
    config.ffmpeg = true
end

print("Welcome to the Lua-based yt-dlp wrapper.")
print("Each download costs $200 monthly. Just kidding!")

dofile("ui/exportType.lua")