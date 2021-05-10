function Save-CEItem {

	<#
		.SYNOPSIS
			Save a file from Cyber Exchange

		.DESCRIPTION
			Takes the object from Get-CEItem and saves it to a location specified.

		.EXAMPLE
			PS C:\> Save-CEItem -Destination "C:\Temp" -URI "https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_STIGViewer_2-14.zip"

			This example shows how to call Save-CEItem and Save a file.

		.EXAMPLE
			PS C:\> Get-CEItem -Section GPOs | Save-CEItem -Destination "C:\Temp"

			This example shows the Get-CEItem function pulling a list of GPOs and it pipes the output to Save-CEItem to download the files.
	#>

	[CmdletBinding()]
	[OutputType([System.Void])]
	param (

		# Specifies the destination to save the file to.
		[Parameter(Mandatory, Position = 0)]
		[String]
		$Destination,

		# Specifies the URL for the file to download from public.cyber.mil
		[Parameter(Mandatory, ValueFromPipelineByPropertyName)]
		[string[]]
		$URI,

		# Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc. Using this parameter is not secure and is not recommended. This switch is only intended to be used against known hosts using a self-signed certificate for testing purposes or a trusted website with an expired certificate. Use at your own risk.
		[Parameter()]
		[Switch]
		$SkipCertificateCheck

	)

	begin {

		$currentProgressPreference = $ProgressPreference
		$ProgressPreference = 'SilentlyContinue'

		if (-not (Test-Path $Destination)) { New-Item -Path $Destination -ItemType Directory | Out-Null }

	}

	process {

		$URI | ForEach-Object {

			$fileName = ($_ -split "/")[-1]
			$saveTo = Join-Path -Path $Destination -ChildPath $fileName

			$params = @{
				URI     = $_
				OutFile = $saveTo
			}

			if ($PSBoundParameters.SkipCertificateCheck) { $params.add('SkipCertificateCheck', $true) }

			Invoke-WebRequest @params

		}

	}

	end {

		$ProgressPreference = $currentProgressPreference

	}

}
