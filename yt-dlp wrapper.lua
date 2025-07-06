local ffmpeg
local inputURL = "https://www.youtube.com/watch?v=OBFX4EuAWHc"
local params = {}

local function getUserInput(prompt)
    if prompt then
        io.write(prompt)
    end
    local input = io.read()
    if input and input:lower() == "quit" then
		print("Exiting program...")
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

local function audioParameters(chosenFormat)
	-- Set Audio Quality

	-- Set Filename Template
end

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
	-- Set video format quality
	local areSubs = false
	local done = false

	-- Embed Subtitles
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
		if done == true then break else end
		if areSubs == false then break end
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
					print("Please note, the program assumes you have selected a compatible subtitle language.")
					print("If the chosen language doesn't work, it could be due to user error or a failure with yt-dlp.")
					break
				elseif confirmation == "n" then
					break
				else
					print("Please type 'y' or 'n'.")
				end
			end
		end
	end
	-- Subtitle Language
end

local function handleExportFormat(selection)

	if ffmpeg == false then
		print("ffmpeg is unavailable; you cannot select the " .. selection .. " option.")
		if selection == "audio" then
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

local function promptExportType()
	while true do
		print("Would you like to export audio or video? Type 'quit' to exit program:")
		local response = getUserInput():lower()
		local exportType

		if response == "video" then
			exportType = "video"
			print("Video export selected.")
			handleExportFormat(exportType)
			break
		elseif response == "audio" then
			exportType = "audio"
			print("Audio export selected.")
			handleExportFormat(exportType)
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

videoParameters()
