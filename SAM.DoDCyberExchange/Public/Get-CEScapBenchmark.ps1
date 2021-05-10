function Get-CEScapBenchmark {

	<#
		.SYNOPSIS
			Retrieves a list of SCAP Benchmarks from Cyber.mil

		.DESCRIPTION
			Retrieves a list of SCAP Benchmarks from Cyber.mil using the Get-CEItem function.

		.EXAMPLE
			PS C:\> Get-CEScapBenchmark | Save-CEItem -Destination C:\Temp\SCAPS

			This example shows the default method to call the function. It pipes the output to Save-CEItem to download the file.

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

		$params = @{ Section = 'DocumentLibrary' }

		if ($PSBoundParameters.SkipCertificateCheck) { $params.add('SkipCertificateCheck', $true) }

		Get-CEItem @params | Where-Object { $_.FileType -eq "zip" -and $_.FileName -Like "*_Benchmark.zip" }

	}

}
