local function video()
    dofile('core/video/video.lua')
end
local function audio()
    dofile('core/audio/audio.lua')
end

if config.ffmpeg == false then
    print("ffmpeg is unavailable; you cannot select the " .. selection .. " option.")
    if selection == "audio" then
        table.insert(params, "-x")
        audio()
    else
        video()
    end
end

local audioOptions = {"mp3", "m4a", "wav", "opus", "flac"}
local videoOptions = {"mp4", "webm", "mkv", "flv", "3gp"}
local validFormats
local invalidFormats

if selection == "audio" then
    validFormats = audioOptions
    invalidFormats = videoOptions
else
    validFormats = videoOptions
    invalidFormats = audioOptions
end

while true do
    print("\nEnter the desired export format (requires ffmpeg). Type 'quit' to exit program:")
    print("\nExporting can require some time to process locally, to avoid formatting, type 'skip'")
    print("Available " .. selection .. " formats: " .. table.concat(validFormats, ", "))
    local isValid = false
    local isInvalid = false
    local chosenFormat = getUserInput():lower()

    if chosenFormat == "skip" then
        if selection == "audio" then
            audio()
            break
        else
            video()
            break
        end
    end

    for _, format in pairs(validFormats) do
        if chosenFormat == format then
            isValid = true
        end
    end

    for _, format in pairs(invalidFormats) do
        if chosenFormat == format then
            isInvalid = true
            print("Invalid choice: '" .. chosenFormat .. "' is not a valid " .. selection .. " format.")
        end
    end

    if not isValid and not isInvalid then
        print("Unrecognized format: '" .. chosenFormat .. "'. Please try again.")
    end

    if isValid then
        print("Format selected: " .. chosenFormat .. "")
        if selection == "audio" then
            table.insert(params, "-x")
            table.insert(params, "--audio-format " .. chosenFormat)
            audio()
            break
        else
            table.insert(params, "--recode-video "..chosenFormat)
            video()
            break
        end
    end
end
