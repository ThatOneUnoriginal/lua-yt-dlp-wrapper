EXTRACTOR OPTIONS

--extractor-retries RETRIES     Number of retries for known extractor errors
                                (default is 3), or "infinite"
--allow-dynamic-mpd             Process dynamic DASH manifests (default)
                                (Alias: --no-ignore-dynamic-mpd)
--ignore-dynamic-mpd            Do not process dynamic DASH manifests
                                (Alias: --no-allow-dynamic-mpd)
--hls-split-discontinuity       Split HLS playlists to different formats at
                                discontinuities such as ad breaks
--no-hls-split-discontinuity    Do not split HLS playlists into different
                                formats at discontinuities such as ad breaks
                                (default)
--extractor-args IE_KEY:ARGS    Pass ARGS arguments to the IE_KEY extractor.
                                See "EXTRACTOR ARGUMENTS" for details. You
                                can use this option multiple times to give
                                arguments for different extractors