function Get-CECompilation {

	<#
		.SYNOPSIS
			Get current STIG Compilation from public.cyber.mil

		.DESCRIPTION
			Get current STIG Compilation from public.cyber.mil. If you need the CUI Compilation you will need to log into the website to download.

		.EXAMPLE
			PS C:\> Get-CECompilation

			This example demonstrates how to pull the STIG compilations for DoD Cyber Exchange.
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

		$params = @{ Section = 'Compilations' }

		if ($PSBoundParameters.SkipCertificateCheck) { $params.add('SkipCertificateCheck', $true) }

		Get-CEItem @params | Where-Object { $_.FileName -and $_.FileType -eq "zip" }
	}

}
