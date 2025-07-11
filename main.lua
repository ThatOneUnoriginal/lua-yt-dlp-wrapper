_G.helper = require("utils.helper")
_G.shared = require("core.shared")
_G.config = require("config")
_G.settings = require("utils.settings")

_G.selection = config["selection"]
_G.params = config["params"]
_G.inputURL = config["inputURL"]
_G.keepParams = config["keepParams"]

_G.getUserInput = helper["getUserInput"]
_G.ytCheck = helper["ytCheck"]

_G.findDefault = settings["findDefault"]
_G.saveNewDefault = settings["saveNewDefault"]

dofile("utils/settings.lua")

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