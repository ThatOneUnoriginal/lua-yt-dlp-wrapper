local url = require("libraries/url")
local ffmpeg
local inputURL
local params = {}
local co
local selection
local promptExportType
local urlInput

local function urlValidation(website)
    -- Parse the URL with LuaSocket
    local parsed = url.parse(website)
    if not (parsed and parsed.scheme and parsed.host) then
        return "invalid"
    end

    -- Simulate yt-dlp execution using the URL
    local handle = io.popen("yt-dlp " .. website .. " 2>&1")
    local result = handle:read("*a")
    handle:close()

    local status
    local lower_result = result:lower()
    -- Check for DRM protection, excluding YouTube
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

local function execution()
    local output = table.concat(params, " ")
    os.execute("yt-dlp -s "..output.." "..inputURL)

    while true do
        print("\nDo you wish to export another "..selection.."?")
        print(" 1) Export again (don't change export type).")
        print(" 2) Export again (allow me to choose export type again).")
        print(" 3) Close application / no thanks.\n")

        local input = io.read()
        if input == "1" then
            print("")
            urlInput()
            break
        elseif input == "2" then
            print("")
            promptExportType()
            break
        elseif input == "3" then
            print("\nExiting program......")
            os.exit()
        else
            print("Please type 1, 2 or 3.")
        end
    end
end

local function getUserInput(prompt)
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

local function silentExecute(cmd)
	local isWindows = package.config:sub(1,1) == "\\"
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

local function customParamaters()
end

local function sharedParameters()
    while true do
        print("\nWould you like to embed metadata? (y/n):")
        local input = getUserInput():lower()

        if input == "y" then
            table.insert(params, "--embed-metadata")
            break
        elseif input == "n" then
            break
        else
            print("Please type 'y' or 'n'.")
        end        
    end

    while true do
        print("\nWould you like to embed thumbnail? (y/n):")
        local input = getUserInput():lower()

        if input == "y" then
            table.insert(params, "--embed-thumbnail")
            break
        elseif input == "n" then
            break
        else
            print("Please type 'y' or 'n'.")
        end        
    end
    coroutine.resume(co)
end

-- This allows users to enable basic options when exporting audio
local function audioParameters()
	-- Set Audio Quality
    -- TODO: Add base options for audioParameters
	-- Set Filename Template
end

-- This allows users to enable more advanced options when exporting video
-- TODO: Add "custom" parameter inputting
local function videoAdvanced()
	local subFormats = {"vtt", "srt", "ttml","json3","srv1","srv2","srv3"}
	local function subtitleFormatting()
		local done = false

		while true do
			if done == true then break end
			print("\nHow would you like to format the subtitle file?")
			print("You can specify one or more formats separated by '/' (e.g., 'srt' or 'ass/srt/best').\n")

			print("Type 'list' if you're unsure which formats are available for a specific video.")
			print("Available formats (Type 'quit' to exit program):")

			for i, format in ipairs(subFormats) do
				io.write(format .. "\t")
			end
			print()

			local format = getUserInput():lower()

			print("")

			os.execute("yt-dlp -s --write-auto-subs --sub-format "..format.." "..inputURL)

			print("\nDo you want to continue with "..format.. " as the subtitle file format? (y/n):")
			local confirmation = getUserInput():lower()

			while true do
				if confirmation == "y" then
					done = true
					table.insert(params, "--sub-format "..format)
					break
				elseif confirmation == "n" then
					break
				else
					print("Please type 'y' or 'n'.")
				end	
			end
		end
	end

	-- Download subtitles into seperate file
	while true do
		print("\nDownload subtitles? (Auto, Manual, Both)")
		print("- Auto: YouTube-generated")
		print("- Manual: Added by author")
		print("- Both: Download both types")
		print("- None (Default)")
		print("Note: Subtitles are downloaded separately, not embedded. Type 'quit' to exit program:")

		local subInput = getUserInput():lower()

		if subInput == "auto" then
			print("YouTube-generated subtitles will be downloaded in a seperate file.")
			table.insert(params, "--write-auto-subs")
			subtitleFormatting()
			break
		elseif subInput == "manual" then
			print("Author-created subtitles will be downloaded in a seperate file.")
			table.insert(params, "--write-subs")
			break
		elseif subInput == "both" then
			print("YouTube-generated and Author-created will be downloaded in a seperate file.")
			table.insert(params, "--write-auto-subs")
			table.insert(params, "--write-subs")
			subtitleFormatting()
			break
		elseif subInput == "" or subInput == "none" then
			print("Subtitles will not be downloaded as a separate file.")
			break
		else
			print("Unrecognized choice. Please enter one of the following: 'auto', 'manual', 'both', or 'none'.")
		end
        
	end
end

local function videoParameters()
    -- This is the coroutine function
    co = coroutine.create(function()
        -- Embed Subtitles
        local areSubs = false
        local done = false

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
                print("Please type 'y' or 'n'.")
            end
        end

        while true do
            if done == true or areSubs == false then break end
            print("\nSelect subtitle language (type 'list' to view available options):")
            local input = getUserInput():lower()
            
            if input == "list" then
                print("")
                os.execute("yt-dlp --list-subs "..inputURL)
            else
                while true do
                    print("\nConfirm selecting " .. input .. " as the subtitle language? (y/n):")
                    local confirmation = getUserInput():lower()

                    if confirmation == "y" then
                        done= true
                        print(input .. " has been set as the subtitle language.")
                        break
                    elseif confirmation == "n" then
                        break
                    else
                        print("Please type 'y' or 'n'.")
                    end
                end
            end
        end

        while true do
            print("\nWould you like to embed video chapters? (y/n):")
            local input = getUserInput():lower()

            if input == "y" then
                table.insert(params, "--embed-chapters")
                break
            elseif input == "n" then
                break
            else
                print("Please type 'y' or 'n'.")
            end
        end

        coroutine.yield()  -- pause here, resume after sharedParameters
        while true do
            print("\nDo you want to choose more advanced options? (y/n):")
            local input = getUserInput():lower()
            if input == "y" then
                print("Moving to advanced video paramater selection.")
                videoAdvanced()
                break
            elseif input == "n" then
                print("Skipping advanced video parameter selection.")
                execution()
                break
            else
                print("Please type 'y' or 'n'.")
            end
        end
        execution()
    end)

    -- Start coroutine
    coroutine.resume(co)
    -- sharedParameters will resume it after finishing
    sharedParameters()
end

local function handleExportFormat()

	if ffmpeg == false then
		print("ffmpeg is unavailable; you cannot select the " .. selection .. " option.")
		if selection == "audio" then
            table.insert(params, "-x")
			audioParameters()
		else
			videoParameters()
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
        print("Available "..selection.." formats: "..table.concat(validFormats, ", "))
		local isValid = false
		local isInvalid = false
		local chosenFormat = getUserInput():lower()

		for _, format in pairs(validFormats) do
			if chosenFormat == format then
				isValid = true
			end
		end

		for _, format in pairs(invalidFormats) do
			if chosenFormat == format then
				isInvalid = true
				print("Invalid choice: '" .. chosenFormat .. "' is not a valid " .. selection .. " format.\n")
			end
		end

		if not isValid and not isInvalid then
			print("Unrecognized format: '" .. chosenFormat .. "'. Please try again.")
		end

		if isValid then
			print("Format selected: "..chosenFormat.."")
			if selection == "audio" then
				table.insert(params, "-x")
				table.insert(params, "--audio-format "..chosenFormat)
				audioParameters()
				break
			else
				videoParameters()
				break
			end
		end
	end
end

function urlInput()
    while true do
        print("\nEnter the URL that you're wanting to export (type 'quit' to exit):")
        inputURL = io.read()

        if inputURL:lower() == "quit" then
            print("Exiting program....")
        else
            print("Validating URL, this may take a couple minutes...")
        end

        local status = urlValidation(inputURL)

        if status == "valid" then
            -- URLs are invalid for reasons specififed in the urlValidation
            print("Valid URL.")
            handleExportFormat()
            break
        elseif status == "invalid" then
            print("Invalid URL. Please enter a valid URL.")
        elseif status == "unsupported" then
            print("Invalid URL. Unfortunately this URL isn't supported by yt-dlp.")
            print(
                "To see a list of supported urls, check https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/heads/master/supportedsites.md"
            )
        elseif status == "nothing" then
            print("Invalid URL. Provided URL will download 0 items.")
        elseif status == "drm_protected" then
            print("Invalid URL. Requested Website is Known to Use DRM Protections.")
            print(
                "To see a list of supported urls, check https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/heads/master/supportedsites.md"
            )
        end
    end
end

function promptExportType()
	while true do
		print("Would you like to export audio or video? Type 'quit' to exit program:")
		selection = getUserInput():lower()

		if selection == "video" then
			print("Video export selected.")
			urlInput()
			break
		elseif selection == "audio" then
			print("Audio export selected.")
            urlInput()
			break
		else
			print("\nInvalid input. Please type 'audio' or 'video'.")
		end
	end
end

local function displayWelcomeMessage()
	print("Welcome to the Lua-based yt-dlp wrapper.")
	print("Each download costs $200 monthly. Just kidding!")

	promptExportType()
end

print("\nChecking to see if yt-dlp is accessible...")

if silentExecute("yt-dlp --version") == 1 then
	error("yt-dlp is not installed or not accessible in PATH.", 2)
else
	print("yt-dlp was accessed successfully!\n")
end

print("Checking to see if ffmpeg is accesisble... ffmpeg is not necessary for wrapper usage...")

if silentExecute("ffmpeg --version") == 1 then
	print("ffmpeg / ffprobe is not installed or not accessible in PATH.")
	print("Parameters like --audio-format cannot work without ffmpeg.\n")
	ffmpeg = false
else
	print("ffmpeg was accessed successfully!\n")
	ffmpeg = true
end

displayWelcomeMessage()
