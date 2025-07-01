# Dependencies  

## Lua  
This yt-dlp script is built with [Lua](https://www.lua.org/home.html), so you'll need Lua installed on your system. The script was developed using **Lua 5.4**, so it's recommended to use this version for compatibility. Older or newer versions may work, but proceed with caution. You can download Lua from the [official website](https://www.lua.org/download.html).  

## LuaRocks  
LuaRocks is required to install an essential library for the program. To get LuaRocks, follow the installation guide on the [LuaRocks GitHub repository](https://luarocks.github.io/luarocks/releases/).  

## LuaSocket  
LuaSocket is necessary for URL validation—without it, the extraction process won't work. Since LuaSocket is installed via LuaRocks, you'll need LuaRocks set up first.  

Once LuaRocks is installed, you can install LuaSocket by running:  
```
luarocks install luasocket
```
