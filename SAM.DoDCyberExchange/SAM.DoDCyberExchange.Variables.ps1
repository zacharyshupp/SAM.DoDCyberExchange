# [Variables] -----------------------------------------------------------------------------------------------------

$SAMRoot = $PSScriptRoot
$SAMHtmlAgilityPackDllPath = [IO.Path]::Combine("$SAMRoot", 'Libraries', 'HTMLAgilityPack', 'Net45', 'HtmlAgilityPack.dll')

$DoDCyberExchangeUrls = @{
	DocumentLibrary = "https://public.cyber.mil/stigs/downloads/"
	SCAPs           = "https://public.cyber.mil/stigs/scap/"
	STIGTools       = "https://public.cyber.mil/stigs/srg-stig-tools/"
	Compilations    = "https://public.cyber.mil/stigs/compilations/"
	GPOs            = "https://public.cyber.mil/stigs/gpo/"
	Automation      = "https://public.cyber.mil/stigs/supplemental-automation-content/"
	CCI             = "https://public.cyber.mil/stigs/cci/"
	Sunset          = "https://public.cyber.mil/stigs/sunset-products/"
}

$certCallback = @"
    using System;
    using System.Net;
    using System.Net.Security;
    using System.Security.Cryptography.X509Certificates;
    public class ServerCertificateValidationCallback
    {
        public static void Ignore()
        {
            if(ServicePointManager.ServerCertificateValidationCallback ==null)
            {
                ServicePointManager.ServerCertificateValidationCallback +=
                    delegate
                    (
                        Object obj,
                        X509Certificate certificate,
                        X509Chain chain,
                        SslPolicyErrors errors
                    )
                    {
                        return true;
                    };
            }
        }
    }
"@

# [Functions] -----------------------------------------------------------------------------------------------------
