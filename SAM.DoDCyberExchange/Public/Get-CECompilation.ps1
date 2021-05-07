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
	param ()

	end {
		Get-CEItem -Section Compilations | Where-Object { $_.FileName -and $_.FileType -eq "zip" }
	}

}
