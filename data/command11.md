VIDEO FORMAT OPTIONS

-f, --format FORMAT             Video format code, see "FORMAT SELECTION"
                                for more details
-S, --format-sort SORTORDER     Sort the formats by the fields given, see
                                "Sorting Formats" for more details
--format-sort-force             Force user specified sort order to have
                                precedence over all fields, see "Sorting
                                Formats" for more details (Alias: --S-force)
--no-format-sort-force          Some fields have precedence over the user
                                specified sort order (default)
--video-multistreams            Allow multiple video streams to be merged
                                into a single file
--no-video-multistreams         Only one video stream is downloaded for each
                                output file (default)
--audio-multistreams            Allow multiple audio streams to be merged
                                into a single file
--no-audio-multistreams         Only one audio stream is downloaded for each
                                output file (default)
--prefer-free-formats           Prefer video formats with free containers
                                over non-free ones of the same quality. Use
                                with "-S ext" to strictly prefer free
                                containers irrespective of quality
--no-prefer-free-formats        Don't give any special preference to free
                                containers (default)
--check-formats                 Make sure formats are selected only from
                                those that are actually downloadable
--check-all-formats             Check all formats for whether they are
                                actually downloadable
--no-check-formats              Do not check that the formats are actually
                                downloadable
-F, --list-formats              List available formats of each video.
                                Simulate unless --no-simulate is used
--merge-output-format FORMAT    Containers that may be used when merging
                                formats, separated by "/", e.g. "mp4/mkv".
                                Ignored if no merge is required. (currently
                                supported: avi, flv, mkv, mov, mp4, webm)