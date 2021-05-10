function Get-CEStig {

	<#
		.SYNOPSIS
			Retrieves a list of STIG/SRG List from public.cyber.mil.

		.DESCRIPTION
			Retrieves a list of STIG/SRG List from public.cyber.mil using the Get-CEItem function. This function also includes all the Sunset STIGs.

		.EXAMPLE
			PS C:\> Get-CEStig | Save-CEItem -Destination C:\Temp\STIGs

			This example shows the default method to call Get-CEStig. It pipes the output to Save-CEItem to download the file.
	#>

	[CmdletBinding()]
	[OutputType([System.Management.Automation.PSCustomObject])]
	param (

		# Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc. Using this parameter is not secure and is not recommended. This switch is only intended to be used against known hosts using a self-signed certificate for testing purposes or a trusted website with an expired certificate. Use at your own risk.
		[Parameter()]
		[Switch]
		$SkipCertificateCheck

	)

	end {

		$exclude = "UNIX_Remote_Scanning|RPM-GPG-KEY|scc-|Draft|Overview|BENCHMARK|STIGViewer|STIGApplicabilityGuide|CCI|Library|Ansible|GPO|Configuration_Files|Audit|Chef|Test"

		$params = @{ Section = 'DocumentLibrary' }

		if ($PSBoundParameters.SkipCertificateCheck) { $params.add('SkipCertificateCheck', $true) }

		Get-CEItem @params |
			Where-Object { $_.FileName -and $_.FileName.ToLower() -notmatch $exclude.ToLower() -and $_.FileType -eq "zip" }

	}

}
