WORKAROUNDS

--encoding ENCODING             Force the specified encoding (experimental)
--legacy-server-connect         Explicitly allow HTTPS connection to servers
                                that do not support RFC 5746 secure
                                renegotiation
--no-check-certificates         Suppress HTTPS certificate validation
--prefer-insecure               Use an unencrypted connection to retrieve
                                information about the video (Currently
                                supported only for YouTube)
--add-headers FIELD:VALUE       Specify a custom HTTP header and its value,
                                separated by a colon ":". You can use this
                                option multiple times
--bidi-workaround               Work around terminals that lack
                                bidirectional text support. Requires bidiv
                                or fribidi executable in PATH
--sleep-requests SECONDS        Number of seconds to sleep between requests
                                during data extraction
--sleep-interval SECONDS        Number of seconds to sleep before each
                                download. This is the minimum time to sleep
                                when used along with --max-sleep-interval
                                (Alias: --min-sleep-interval)
--max-sleep-interval SECONDS    Maximum number of seconds to sleep. Can only
                                be used along with --min-sleep-interval
--sleep-subtitles SECONDS       Number of seconds to sleep before each
                                subtitle download