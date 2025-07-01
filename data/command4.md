VIDEO SELECTION

-I, --playlist-items ITEM_SPEC  Comma separated playlist_index of the items
                                to download. You can specify a range using
                                "[START]:[STOP][:STEP]". For backward
                                compatibility, START-STOP is also supported.
                                Use negative indices to count from the right
                                and negative STEP to download in reverse
                                order. E.g. "-I 1:3,7,-5::2" used on a
                                playlist of size 15 will download the items
                                at index 1,2,3,7,11,13,15
--min-filesize SIZE             Abort download if filesize is smaller than
                                SIZE, e.g. 50k or 44.6M
--max-filesize SIZE             Abort download if filesize is larger than
                                SIZE, e.g. 50k or 44.6M
--date DATE                     Download only videos uploaded on this date.
                                The date can be "YYYYMMDD" or in the format 
                                [now|today|yesterday][-N[day|week|month|year]].
                                E.g. "--date today-2weeks" downloads only
                                videos uploaded on the same day two weeks ago
--datebefore DATE               Download only videos uploaded on or before
                                this date. The date formats accepted are the
                                same as --date
--dateafter DATE                Download only videos uploaded on or after
                                this date. The date formats accepted are the
                                same as --date
--match-filters FILTER          Generic video filter. Any "OUTPUT TEMPLATE"
                                field can be compared with a number or a
                                string using the operators defined in
                                "Filtering Formats". You can also simply
                                specify a field to match if the field is
                                present, use "!field" to check if the field
                                is not present, and "&" to check multiple
                                conditions. Use a "\" to escape "&" or
                                quotes if needed. If used multiple times,
                                the filter matches if at least one of the
                                conditions is met. E.g. --match-filters
                                !is_live --match-filters "like_count>?100 &
                                description~='(?i)\bcats \& dogs\b'" matches
                                only videos that are not live OR those that
                                have a like count more than 100 (or the like
                                field is not available) and also has a
                                description that contains the phrase "cats &
                                dogs" (caseless). Use "--match-filters -" to
                                interactively ask whether to download each
                                video
--no-match-filters              Do not use any --match-filters (default)
--break-match-filters FILTER    Same as "--match-filters" but stops the
                                download process when a video is rejected
--no-break-match-filters        Do not use any --break-match-filters (default)
--no-playlist                   Download only the video, if the URL refers
                                to a video and a playlist
--yes-playlist                  Download the playlist, if the URL refers to
                                a video and a playlist
--age-limit YEARS               Download only videos suitable for the given
                                age
--download-archive FILE         Download only videos not listed in the
                                archive file. Record the IDs of all
                                downloaded videos in it
--no-download-archive           Do not use archive file (default)
--max-downloads NUMBER          Abort after downloading NUMBER files
--break-on-existing             Stop the download process when encountering
                                a file that is in the archive supplied with
                                the --download-archive option
--no-break-on-existing          Do not stop the download process when
                                encountering a file that is in the archive
                                (default)
--break-per-input               Alters --max-downloads, --break-on-existing,
                                --break-match-filters, and autonumber to
                                reset per input URL
--no-break-per-input            --break-on-existing and similar options
                                terminates the entire download queue
--skip-playlist-after-errors N  Number of allowed failures until the rest of
                                the playlist is skipped