GEO-RESTRICTION

--geo-verification-proxy URL    Use this proxy to verify the IP address for
                                some geo-restricted sites. The default proxy
                                specified by --proxy (or none, if the option
                                is not present) is used for the actual
                                downloading
--xff VALUE                     How to fake X-Forwarded-For HTTP header to
                                try bypassing geographic restriction. One of
                                "default" (only when known to be useful),
                                "never", an IP block in CIDR notation, or a
                                two-letter ISO 3166-2 country code