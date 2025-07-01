SUBTITLE OPTIONS

--write-subs                    Write subtitle file
--no-write-subs                 Do not write subtitle file (default)
--write-auto-subs               Write automatically generated subtitle file
                                (Alias: --write-automatic-subs)
--no-write-auto-subs            Do not write auto-generated subtitles
                                (default) (Alias: --no-write-automatic-subs)
--list-subs                     List available subtitles of each video.
                                Simulate unless --no-simulate is used
--sub-format FORMAT             Subtitle format; accepts formats preference
                                separated by "/", e.g. "srt" or "ass/srt/best"
--sub-langs LANGS               Languages of the subtitles to download (can
                                be regex) or "all" separated by commas, e.g.
                                --sub-langs "en.*,ja" (where "en.*" is a
                                regex pattern that matches "en" followed by
                                0 or more of any character). You can prefix
                                the language code with a "-" to exclude it
                                from the requested languages, e.g. --sub-
                                langs all,-live_chat. Use --list-subs for a
                                list of available language tags