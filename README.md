# TODO
## Save Location
By default, downloaded files are saved to the application’s root directory. While users can currently override this via a custom parameter, given its frequent use, save location configuration will be moved to the sharedParameters() section for easier access.

## Exclusion File
At present, previously downloaded items can be downloaded again, which is inconvenient—especially when handling playlists where only new content is desired. Although this can be configured with a custom parameter, support for an exclusion file will also be added to the sharedParameters() section to improve usability for typical users.

## Default Locations
To streamline repeated usage, default paths will be introduced for both save locations and exclusion files. When prompted to set these paths, users can either accept the current default by pressing Enter or input a new location. If a new path is provided, the user will be asked whether they want to save it as the new default.

## Bundle yt-dlp
Since yt-dlp is a core dependency without which the application cannot function, it's important to ensure it's always reliably available. Currently, users are required to install yt-dlp manually and ensure it’s accessible—typically by adding it to their system’s environment variables. To improve usability and reduce setup friction, the application should consider bundling yt-dlp directly, or automatically downloading it on first run, eliminating the need for manual installation and configuration by the user.

## Finish audioParameters
Currently, if a user selects the option to export audio, they encounter a dead end, as the audioParameters() function is non-functional. Functionality needs to be implemented within audioParameters() to handle audio-specific options and parameters.

## Custom Paremter Confirmation
Currently, the application assumes users entering custom parameters are experienced and provides no safeguards against errors. While it's reasonable to expect advanced users to be familiar with yt-dlp syntax, introducing validation could significantly improve usability. For instance, detecting and notifying users about misspelled or invalid parameters would help catch mistakes early, prevent silent failures, and improve overall reliability.

# Questions
## What systems are supported?
Lua is available for Windows, macOS, and Linux. If you're using Linux or macOS, Lua may already be installed or available through your system's package manager. If not, check the dependencies for installation instructions. While there are Lua apps on the Google Play Store (like Exec Lua) and Apple App Store (such as LuaLu REPL), I cannot say with assurance that this will work there.

## Will you ever provide a cloud-based option?
No, I don't have the resources for that. If you're looking for a cloud-based solution, I'd recommend using [cobalt.tools](https://cobalt.tools/). For obvious reasons, I cannot assure you that everything possible with this yt-dlp wrapper will be directly achievable with Cobalt Tools or that it'll be available at any time.

## Why Lua?
I love Roblox, and since Roblox uses Lua, I've always wanted to learn it. I'm using this opportunity to explore Lua and figure out how to create chaotic and fun things for myself in Roblox.

## Is it TRULY free?
Yes. If you want to verify that there's no payment processing or request for payment details, you can inspect the Lua files themselves. Everything runs locally on the device where the app is installed, so it never needs to process anything on an external server. This means there's no cost to me for its active usage.

## Why a yt-dlp wrapper?

There are two reasons. First, I use yt-dlp frequently, and it can be tedious to remember and retype the same parameters every time. Second, I thought this project would be complex enough to challenge my Lua skills. When I created this application, I had only built a few small programs—a tax calculator, a word scrambler, and a number-guessing game.

## You're replacing a cli with... another cli?
Yes, but from what I understand, creating UI windows requires an additional Lua library. I believe I should focus on mastering the core functionality first before tackling that challenge. In other words, this CLI application is a stepping stone toward eventually developing a GUI version.

## Will you accept push requests?

It depends. Since this program is meant to test my Lua skills, I prefer not to rely on others' code when possible. If a pull request adds features I could implement myself, it probably won't be accepted. However, I may accept fixes for overlooked issues or more efficient implementations of existing functions. In general, I'd prefer if you opened an issue first instead.

## Is this a "vibe-coded" yt-dlp wrapper?
It's a mix. I wrote about 90% of the code myself. I only use AI to help me understand unfamiliar concepts (like new functions) or to debug errors I can't figure out right away. I've never asked AI to "write the entire program so I could charge ridiculous prices while falsely claiming it's free" (if you know, you know). I also used AI to check the ReadMe, but only for grammar fixes.

## When will this be considered complete?
This might be ambitious, but I want to create a version of the application that fully utilizes yt-dlp's capabilities—a complete wrapper, not just a limited version with functions I arbitrarily deem "popular enough." At the very least, I'm aiming to implement all the basic parameters.
# Dependencies  

## Lua  
This yt-dlp script is built with [Lua](https://www.lua.org/home.html), so you'll need Lua installed on your system. The script was developed using **Lua 5.4**, so it's recommended to use this version for compatibility. Older or newer versions may work, but proceed with caution. You can download Lua from the [official website](https://www.lua.org/download.html).

## yt-dlp
**yt-dlp** is a powerful command-line tool for downloading audio and video from thousands of websites. Unlike cloud-based solutions, all processing happens locally meaning you must have **yt-dlp** installed on your device.  

### Installation Options:  
- Place the **yt-dlp** executable in the same folder as the `.lua` script.  
- **OR** add **yt-dlp** to your system's **environment variables** for global access.  

To verify that the Lua script can detect **yt-dlp**, open a terminal in the script's directory and run:  
```
yt-dlp
```  
If installed correctly, this will display the help menu.  

### Additional Dependencies  
While **yt-dlp** has its own dependencies, the Lua wrapper does not directly require them. However, for full functionality (e.g., merging video/audio streams or post-processing), I recommend installing:  
- **FFmpeg** (includes `ffprobe`)  

For a complete list of **yt-dlp** dependencies, check the [official repository](https://github.com/ThatOneUnoriginal/lua-yt-dlp-wrapper).