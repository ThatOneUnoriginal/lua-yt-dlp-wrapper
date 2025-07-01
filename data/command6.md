FILESYSTEM OPTIONS

-a, --batch-file FILE           File containing URLs to download ("-" for
                                stdin), one URL per line. Lines starting
                                with "#", ";" or "]" are considered as
                                comments and ignored
--no-batch-file                 Do not read URLs from batch file (default)
-P, --paths [TYPES:]PATH        The paths where the files should be
                                downloaded. Specify the type of file and the
                                path separated by a colon ":". All the same
                                TYPES as --output are supported.
                                Additionally, you can also provide "home"
                                (default) and "temp" paths. All intermediary
                                files are first downloaded to the temp path
                                and then the final files are moved over to
                                the home path after download is finished.
                                This option is ignored if --output is an
                                absolute path
-o, --output [TYPES:]TEMPLATE   Output filename template; see "OUTPUT
                                TEMPLATE" for details
--output-na-placeholder TEXT    Placeholder for unavailable fields in
                                --output (default: "NA")
--restrict-filenames            Restrict filenames to only ASCII characters,
                                and avoid "&" and spaces in filenames
--no-restrict-filenames         Allow Unicode characters, "&" and spaces in
                                filenames (default)
--windows-filenames             Force filenames to be Windows-compatible
--no-windows-filenames          Sanitize filenames only minimally
--trim-filenames LENGTH         Limit the filename length (excluding
                                extension) to the specified number of
                                characters
-w, --no-overwrites             Do not overwrite any files
--force-overwrites              Overwrite all video and metadata files. This
                                option includes --no-continue
--no-force-overwrites           Do not overwrite the video, but overwrite
                                related files (default)
-c, --continue                  Resume partially downloaded files/fragments
                                (default)
--no-continue                   Do not resume partially downloaded
                                fragments. If the file is not fragmented,
                                restart download of the entire file
--part                          Use .part files instead of writing directly
                                into output file (default)
--no-part                       Do not use .part files - write directly into
                                output file
--mtime                         Use the Last-modified header to set the file
                                modification time (default)
--no-mtime                      Do not use the Last-modified header to set
                                the file modification time
--write-description             Write video description to a .description file
--no-write-description          Do not write video description (default)
--write-info-json               Write video metadata to a .info.json file
                                (this may contain personal information)
--no-write-info-json            Do not write video metadata (default)
--write-playlist-metafiles      Write playlist metadata in addition to the
                                video metadata when using --write-info-json,
                                --write-description etc. (default)
--no-write-playlist-metafiles   Do not write playlist metadata when using
                                --write-info-json, --write-description etc.
--clean-info-json               Remove some internal metadata such as
                                filenames from the infojson (default)
--no-clean-info-json            Write all fields to the infojson
--write-comments                Retrieve video comments to be placed in the
                                infojson. The comments are fetched even
                                without this option if the extraction is
                                known to be quick (Alias: --get-comments)
--no-write-comments             Do not retrieve video comments unless the
                                extraction is known to be quick (Alias:
                                --no-get-comments)
--load-info-json FILE           JSON file containing the video information
                                (created with the "--write-info-json" option)
--cookies FILE                  Netscape formatted file to read cookies from
                                and dump cookie jar in
--no-cookies                    Do not read/dump cookies from/to file
                                (default)
--cookies-from-browser BROWSER[+KEYRING][:PROFILE][::CONTAINER]
                                The name of the browser to load cookies
                                from. Currently supported browsers are:
                                brave, chrome, chromium, edge, firefox,
                                opera, safari, vivaldi, whale. Optionally,
                                the KEYRING used for decrypting Chromium
                                cookies on Linux, the name/path of the
                                PROFILE to load cookies from, and the
                                CONTAINER name (if Firefox) ("none" for no
                                container) can be given with their
                                respective separators. By default, all
                                containers of the most recently accessed
                                profile are used. Currently supported
                                keyrings are: basictext, gnomekeyring,
                                kwallet, kwallet5, kwallet6
--no-cookies-from-browser       Do not load cookies from browser (default)
--cache-dir DIR                 Location in the filesystem where yt-dlp can
                                store some downloaded information (such as
                                client ids and signatures) permanently. By
                                default ${XDG_CACHE_HOME}/yt-dlp
--no-cache-dir                  Disable filesystem caching
--rm-cache-dir                  Delete all filesystem cache files