NETWORK OPTIONS

--proxy URL                     Use the specified HTTP/HTTPS/SOCKS proxy. To
                                enable SOCKS proxy, specify a proper scheme,
                                e.g. socks5://user:pass@127.0.0.1:1080/.
                                Pass in an empty string (--proxy "") for
                                direct connection
--socket-timeout SECONDS        Time to wait before giving up, in seconds
--source-address IP             Client-side IP address to bind to
--impersonate CLIENT[:OS]       Client to impersonate for requests. E.g.
                                chrome, chrome-110, chrome:windows-10. Pass
                                --impersonate="" to impersonate any client.
                                Note that forcing impersonation for all
                                requests may have a detrimental impact on
                                download speed and stability
--list-impersonate-targets      List available clients to impersonate.
-4, --force-ipv4                Make all connections via IPv4
-6, --force-ipv6                Make all connections via IPv6
--enable-file-urls              Enable file:// URLs. This is disabled by
                                default for security reasons.