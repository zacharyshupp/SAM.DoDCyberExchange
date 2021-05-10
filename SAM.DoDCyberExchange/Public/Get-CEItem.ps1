function Get-CEItem {

	<#
		.SYNOPSIS
			Retrieve list of all files from a specific Cyber Exchange URL.

		.DESCRIPTION
			Retrieve list of all files from a specific Cyber Exchange URL. The function calls the URL and looks for any tables on the page that would list files. This function only works with the public.cyber.mil website, for items that require a CAC to download you will have to log in via the web browser and download manually.

			Useful URLS
            Document Library: https://public.cyber.mil/stigs/downloads/
            SCAPs:            https://public.cyber.mil/stigs/scap/
            STIG/SRG Tools:   https://public.cyber.mil/stigs/srg-stig-tools/
            Compilations:     https://public.cyber.mil/stigs/compilations/
            GPOs:             https://public.cyber.mil/stigs/gpo/
            Automation:       https://public.cyber.mil/stigs/supplemental-automation-content/
            CCI:              https://public.cyber.mil/stigs/cci/
            Sunset:           https://public.cyber.mil/stigs/sunset-products/c=

		.EXAMPLE
			PS C:\> Get-CEItem

			This example demonstrates how to call the function in its default configuration. When called by itself, the function will query the downloads section of DoD Cyber Exchange.

		.EXAMPLE
			PS C:\> Get-CEItem -Section compilations

			This example demonstrates how to pull the STIG compilations for DoD Cyber Exchange.

	#>

	[CmdletBinding()]
	[OutputType([System.Management.Automation.PSCustomObject])]
	param (

		# Specifies the Cyber.Mil Site Section to retrieve file list from. The default value is 'DocumentLibrary' which is the main list of items to download. Other options are "SCAPs","STIGTools","Compilations","GPOs","Automation","CCI","Sunset".
		[Parameter()]
		[ValidateSet(
            "DocumentLibrary",
            "SCAPs",
            "STIGTools",
            "Compilations",
            "GPOs",
            "Automation",
            "CCI",
            "Sunset"
		)]
		[String]
		$Section = 'DocumentLibrary',

        # Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc. Using this parameter is not secure and is not recommended. This switch is only intended to be used against known hosts using a self-signed certificate for testing purposes or a trusted website with an expired certificate. Use at your own risk.
        [Parameter()]
        [Switch]
        $SkipCertificateCheck

	)

	begin {

        Import-HtmlAgilityPack

	}

	end {

        try{

            $params = @{
                URI         = $DoDCyberExchangeUrls.$Section
                Method      = 'Get'
                ErrorAction = 'Stop'
            }

            if ($PSBoundParameters.SkipCertificateCheck) {

                if ($PSVersionTable.PSVersion.Major -gt 5) {
                    $params.Add('SkipCertificateCheck', $true)
                }
                else {
                    Add-Type $certCallback
                    [ServerCertificateValidationCallback]::Ignore()
                }

            }

            Write-Verbose "Retrieving list from: $($params.URI)"

            $response = Invoke-WebRequest @params

            if ($response.StatusCode -eq '200') {

                $htmlDoc = New-Object HtmlAgilityPack.HtmlDocument

                $htmlDoc.LoadHtml($response.rawcontent)

                $htmlDoc.DocumentNode.SelectNodes('//tr[@class="file"]') | ForEach-Object {

                    [XML]$list = $($_.OuterHtml -replace "&mdash;|&nbsp;")
                    [String]$uri = ""
                    [String]$fileType = ""
                    [String]$fileName = ""
                    [String]$msg = ""

                    $link = $list.SelectNodes("//td[@class='title_column']").A.href
                    $size = $list.SelectNodes("//td[@class='size_column']").'#Text'

                    # When looking through list it was found that some items that dont have downloads, have a message nested in the title.
                    if ($link) {
                        $uri = $link.Trim()
                        $fileType = $($link -split "/")[-1].Split('.')[-1]
                        $fileName = $($link -split "/")[-1]
                    }
                    else {
                        $msg = $list.SelectNodes("//td[@class='title_column']").div."#text".Trim()
                    }

                    [PSCustomObject]@{
                        Name      = $list.SelectNodes("//td[@class='title_column']/span[@style='display:none;']").'#text'.Trim()
                        URI       = $uri
                        FileName  = $fileName
                        FileType  = $fileType
                        Size      = $(If ($size.Length -gt "0") { $size.trim() }else { "---" })
                        Published = $list.SelectNodes("//td[@class='updated_column']").div."#text"
                        Message   = $msg
                    }

                }

            }
            else {

                Throw $response.StatusCode

            }

        }catch{

            Throw $_

        }

	}

}
