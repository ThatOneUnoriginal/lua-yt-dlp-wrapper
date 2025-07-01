AUTHENTICATION OPTIONS

-u, --username USERNAME         Login with this account ID
-p, --password PASSWORD         Account password. If this option is left
                                out, yt-dlp will ask interactively
-2, --twofactor TWOFACTOR       Two-factor authentication code
-n, --netrc                     Use .netrc authentication data
--netrc-location PATH           Location of .netrc authentication data;
                                either the path or its containing directory.
                                Defaults to ~/.netrc
--netrc-cmd NETRC_CMD           Command to execute to get the credentials
                                for an extractor.
--video-password PASSWORD       Video-specific password
--ap-mso MSO                    Adobe Pass multiple-system operator (TV
                                provider) identifier, use --ap-list-mso for
                                a list of available MSOs
--ap-username USERNAME          Multiple-system operator account login
--ap-password PASSWORD          Multiple-system operator account password.
                                If this option is left out, yt-dlp will ask
                                interactively
--ap-list-mso                   List all supported multiple-system operators
--client-certificate CERTFILE   Path to client certificate file in PEM
                                format. May include the private key
--client-certificate-key KEYFILE
                                Path to private key file for client
                                certificate
--client-certificate-password PASSWORD
                                Password for client certificate private key,
                                if encrypted. If not provided, and the key
                                is encrypted, yt-dlp will ask interactively