POST-PROCESSING OPTIONS

-x, --extract-audio             Convert video files to audio-only files
                                (requires ffmpeg and ffprobe)
--audio-format FORMAT           Format to convert the audio to when -x is
                                used. (currently supported: best (default),
                                aac, alac, flac, m4a, mp3, opus, vorbis,
                                wav). You can specify multiple rules using
                                similar syntax as --remux-video
--audio-quality QUALITY         Specify ffmpeg audio quality to use when
                                converting the audio with -x. Insert a value
                                between 0 (best) and 10 (worst) for VBR or a
                                specific bitrate like 128K (default 5)
--remux-video FORMAT            Remux the video into another container if
                                necessary (currently supported: avi, flv,
                                gif, mkv, mov, mp4, webm, aac, aiff, alac,
                                flac, m4a, mka, mp3, ogg, opus, vorbis,
                                wav). If the target container does not
                                support the video/audio codec, remuxing will
                                fail. You can specify multiple rules; e.g.
                                "aac>m4a/mov>mp4/mkv" will remux aac to m4a,
                                mov to mp4 and anything else to mkv
--recode-video FORMAT           Re-encode the video into another format if
                                necessary. The syntax and supported formats
                                are the same as --remux-video
--postprocessor-args NAME:ARGS  Give these arguments to the postprocessors.
                                Specify the postprocessor/executable name
                                and the arguments separated by a colon ":"
                                to give the argument to the specified
                                postprocessor/executable. Supported PP are:
                                Merger, ModifyChapters, SplitChapters,
                                ExtractAudio, VideoRemuxer, VideoConvertor,
                                Metadata, EmbedSubtitle, EmbedThumbnail,
                                SubtitlesConvertor, ThumbnailsConvertor,
                                FixupStretched, FixupM4a, FixupM3u8,
                                FixupTimestamp and FixupDuration. The
                                supported executables are: AtomicParsley,
                                FFmpeg and FFprobe. You can also specify
                                "PP+EXE:ARGS" to give the arguments to the
                                specified executable only when being used by
                                the specified postprocessor. Additionally,
                                for ffmpeg/ffprobe, "_i"/"_o" can be
                                appended to the prefix optionally followed
                                by a number to pass the argument before the
                                specified input/output file, e.g. --ppa
                                "Merger+ffmpeg_i1:-v quiet". You can use
                                this option multiple times to give different
                                arguments to different postprocessors.
                                (Alias: --ppa)
-k, --keep-video                Keep the intermediate video file on disk
                                after post-processing
--no-keep-video                 Delete the intermediate video file after
                                post-processing (default)
--post-overwrites               Overwrite post-processed files (default)
--no-post-overwrites            Do not overwrite post-processed files
--embed-subs                    Embed subtitles in the video (only for mp4,
                                webm and mkv videos)
--no-embed-subs                 Do not embed subtitles (default)
--embed-thumbnail               Embed thumbnail in the video as cover art
--no-embed-thumbnail            Do not embed thumbnail (default)
--embed-metadata                Embed metadata to the video file. Also
                                embeds chapters/infojson if present unless
                                --no-embed-chapters/--no-embed-info-json are
                                used (Alias: --add-metadata)
--no-embed-metadata             Do not add metadata to file (default)
                                (Alias: --no-add-metadata)
--embed-chapters                Add chapter markers to the video file
                                (Alias: --add-chapters)
--no-embed-chapters             Do not add chapter markers (default) (Alias:
                                --no-add-chapters)
--embed-info-json               Embed the infojson as an attachment to
                                mkv/mka video files
--no-embed-info-json            Do not embed the infojson as an attachment
                                to the video file
--parse-metadata [WHEN:]FROM:TO
                                Parse additional metadata like title/artist
                                from other fields; see "MODIFYING METADATA"
                                for details. Supported values of "WHEN" are
                                the same as that of --use-postprocessor
                                (default: pre_process)
--replace-in-metadata [WHEN:]FIELDS REGEX REPLACE
                                Replace text in a metadata field using the
                                given regex. This option can be used
                                multiple times. Supported values of "WHEN"
                                are the same as that of --use-postprocessor
                                (default: pre_process)
--xattrs                        Write metadata to the video file's xattrs
                                (using Dublin Core and XDG standards)
--concat-playlist POLICY        Concatenate videos in a playlist. One of
                                "never", "always", or "multi_video"
                                (default; only when the videos form a single
                                show). All the video files must have the
                                same codecs and number of streams to be
                                concatenable. The "pl_video:" prefix can be
                                used with "--paths" and "--output" to set
                                the output filename for the concatenated
                                files. See "OUTPUT TEMPLATE" for details
--fixup POLICY                  Automatically correct known faults of the
                                file. One of never (do nothing), warn (only
                                emit a warning), detect_or_warn (the
                                default; fix the file if we can, warn
                                otherwise), force (try fixing even if the
                                file already exists)
--ffmpeg-location PATH          Location of the ffmpeg binary; either the
                                path to the binary or its containing directory
--exec [WHEN:]CMD               Execute a command, optionally prefixed with
                                when to execute it, separated by a ":".
                                Supported values of "WHEN" are the same as
                                that of --use-postprocessor (default:
                                after_move). The same syntax as the output
                                template can be used to pass any field as
                                arguments to the command. If no fields are
                                passed, %(filepath,_filename|)q is appended
                                to the end of the command. This option can
                                be used multiple times
--no-exec                       Remove any previously defined --exec
--convert-subs FORMAT           Convert the subtitles to another format
                                (currently supported: ass, lrc, srt, vtt).
                                Use "--convert-subs none" to disable
                                conversion (default) (Alias: --convert-
                                subtitles)
--convert-thumbnails FORMAT     Convert the thumbnails to another format
                                (currently supported: jpg, png, webp). You
                                can specify multiple rules using similar
                                syntax as "--remux-video". Use "--convert-
                                thumbnails none" to disable conversion
                                (default)
--split-chapters                Split video into multiple files based on
                                internal chapters. The "chapter:" prefix can
                                be used with "--paths" and "--output" to set
                                the output filename for the split files. See
                                "OUTPUT TEMPLATE" for details
--no-split-chapters             Do not split video based on chapters (default)
--remove-chapters REGEX         Remove chapters whose title matches the
                                given regular expression. The syntax is the
                                same as --download-sections. This option can
                                be used multiple times
--no-remove-chapters            Do not remove any chapters from the file
                                (default)
--force-keyframes-at-cuts       Force keyframes at cuts when
                                downloading/splitting/removing sections.
                                This is slow due to needing a re-encode, but
                                the resulting video may have fewer artifacts
                                around the cuts
--no-force-keyframes-at-cuts    Do not force keyframes around the chapters
                                when cutting/splitting (default)
--use-postprocessor NAME[:ARGS]
                                The (case-sensitive) name of plugin
                                postprocessors to be enabled, and
                                (optionally) arguments to be passed to it,
                                separated by a colon ":". ARGS are a
                                semicolon ";" delimited list of NAME=VALUE.
                                The "when" argument determines when the
                                postprocessor is invoked. It can be one of
                                "pre_process" (after video extraction),
                                "after_filter" (after video passes filter),
                                "video" (after --format; before
                                --print/--output), "before_dl" (before each
                                video download), "post_process" (after each
                                video download; default), "after_move"
                                (after moving the video file to its final
                                location), "after_video" (after downloading
                                and processing all formats of a video), or
                                "playlist" (at end of playlist). This option
                                can be used multiple times to add different
                                postprocessors