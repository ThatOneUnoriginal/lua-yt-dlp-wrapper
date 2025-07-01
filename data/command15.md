SPONSORBLOCK OPTIONS

--sponsorblock-mark CATS        SponsorBlock categories to create chapters
                                for, separated by commas. Available
                                categories are sponsor, intro, outro,
                                selfpromo, preview, filler, interaction,
                                music_offtopic, poi_highlight, chapter, all
                                and default (=all). You can prefix the
                                category with a "-" to exclude it. See [1]
                                for descriptions of the categories. E.g.
                                --sponsorblock-mark all,-preview
                                [1] https://wiki.sponsor.ajay.app/w/Segment_Categories
--sponsorblock-remove CATS      SponsorBlock categories to be removed from
                                the video file, separated by commas. If a
                                category is present in both mark and remove,
                                remove takes precedence. The syntax and
                                available categories are the same as for
                                --sponsorblock-mark except that "default"
                                refers to "all,-filler" and poi_highlight,
                                chapter are not available
--sponsorblock-chapter-title TEMPLATE
                                An output template for the title of the
                                SponsorBlock chapters created by
                                --sponsorblock-mark. The only available
                                fields are start_time, end_time, category,
                                categories, name, category_names. Defaults
                                to "[SponsorBlock]: %(category_names)l"
--no-sponsorblock               Disable both --sponsorblock-mark and
                                --sponsorblock-remove
--sponsorblock-api URL          SponsorBlock API location, defaults to
                                https://sponsor.ajay.app