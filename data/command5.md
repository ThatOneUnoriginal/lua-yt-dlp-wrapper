DOWNLOAD OPTIONS

-N, --concurrent-fragments N    Number of fragments of a dash/hlsnative
                                video that should be downloaded concurrently
                                (default is 1)
-r, --limit-rate RATE           Maximum download rate in bytes per second,
                                e.g. 50K or 4.2M
--throttled-rate RATE           Minimum download rate in bytes per second
                                below which throttling is assumed and the
                                video data is re-extracted, e.g. 100K
-R, --retries RETRIES           Number of retries (default is 10), or
                                "infinite"
--file-access-retries RETRIES   Number of times to retry on file access
                                error (default is 3), or "infinite"
--fragment-retries RETRIES      Number of retries for a fragment (default is
                                10), or "infinite" (DASH, hlsnative and ISM)
--retry-sleep [TYPE:]EXPR       Time to sleep between retries in seconds
                                (optionally) prefixed by the type of retry
                                (http (default), fragment, file_access,
                                extractor) to apply the sleep to. EXPR can
                                be a number, linear=START[:END[:STEP=1]] or
                                exp=START[:END[:BASE=2]]. This option can be
                                used multiple times to set the sleep for the
                                different retry types, e.g. --retry-sleep
                                linear=1::2 --retry-sleep fragment:exp=1:20
--skip-unavailable-fragments    Skip unavailable fragments for DASH,
                                hlsnative and ISM downloads (default)
                                (Alias: --no-abort-on-unavailable-fragments)
--abort-on-unavailable-fragments
                                Abort download if a fragment is unavailable
                                (Alias: --no-skip-unavailable-fragments)
--keep-fragments                Keep downloaded fragments on disk after
                                downloading is finished
--no-keep-fragments             Delete downloaded fragments after
                                downloading is finished (default)
--buffer-size SIZE              Size of download buffer, e.g. 1024 or 16K
                                (default is 1024)
--resize-buffer                 The buffer size is automatically resized
                                from an initial value of --buffer-size
                                (default)
--no-resize-buffer              Do not automatically adjust the buffer size
--http-chunk-size SIZE          Size of a chunk for chunk-based HTTP
                                downloading, e.g. 10485760 or 10M (default
                                is disabled). May be useful for bypassing
                                bandwidth throttling imposed by a webserver
                                (experimental)
--playlist-random               Download playlist videos in random order
--lazy-playlist                 Process entries in the playlist as they are
                                received. This disables n_entries,
                                --playlist-random and --playlist-reverse
--no-lazy-playlist              Process videos in the playlist only after
                                the entire playlist is parsed (default)
--xattr-set-filesize            Set file xattribute ytdl.filesize with
                                expected file size
--hls-use-mpegts                Use the mpegts container for HLS videos;
                                allowing some players to play the video
                                while downloading, and reducing the chance
                                of file corruption if download is
                                interrupted. This is enabled by default for
                                live streams
--no-hls-use-mpegts             Do not use the mpegts container for HLS
                                videos. This is default when not downloading
                                live streams
--download-sections REGEX       Download only chapters that match the
                                regular expression. A "*" prefix denotes
                                time-range instead of chapter. Negative
                                timestamps are calculated from the end.
                                "*from-url" can be used to download between
                                the "start_time" and "end_time" extracted
                                from the URL. Needs ffmpeg. This option can
                                be used multiple times to download multiple
                                sections, e.g. --download-sections
                                "*10:15-inf" --download-sections "intro"
--downloader [PROTO:]NAME       Name or path of the external downloader to
                                use (optionally) prefixed by the protocols
                                (http, ftp, m3u8, dash, rstp, rtmp, mms) to
                                use it for. Currently supports native,
                                aria2c, avconv, axel, curl, ffmpeg, httpie,
                                wget. You can use this option multiple times
                                to set different downloaders for different
                                protocols. E.g. --downloader aria2c
                                --downloader "dash,m3u8:native" will use
                                aria2c for http/ftp downloads, and the
                                native downloader for dash/m3u8 downloads
                                (Alias: --external-downloader)
--downloader-args NAME:ARGS     Give these arguments to the external
                                downloader. Specify the downloader name and
                                the arguments separated by a colon ":". For
                                ffmpeg, arguments can be passed to different
                                positions using the same syntax as
                                --postprocessor-args. You can use this
                                option multiple times to give different
                                arguments to different downloaders (Alias:
                                --external-downloader-args)