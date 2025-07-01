PRESET ALIASES

-t mp3                          -f 'ba[acodec^=mp3]/ba/b' -x --audio-format
                                mp3

-t aac                          -f
                                'ba[acodec^=aac]/ba[acodec^=mp4a.40.]/ba/b'
                                -x --audio-format aac

-t mp4                          --merge-output-format mp4 --remux-video mp4
                                -S vcodec:h264,lang,quality,res,fps,hdr:12,a
                                codec:aac

-t mkv                          --merge-output-format mkv --remux-video mkv

-t sleep                        --sleep-subtitles 5 --sleep-requests 0.75
                                --sleep-interval 10 --max-sleep-interval 20