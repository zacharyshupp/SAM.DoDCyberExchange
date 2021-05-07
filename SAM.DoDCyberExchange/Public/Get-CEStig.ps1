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
	param ()

	begin {

		$exclude = "UNIX_Remote_Scanning|RPM-GPG-KEY|scc-|Draft|Overview|BENCHMARK|STIGViewer|STIGApplicabilityGuide|CCI|Library|Ansible|GPO|Configuration_Files|Audit|Chef|Test"

	}

	end {

		Get-CEItem -Section DocumentLibrary |
			Where-Object { $_.FileName -and $_.FileName.ToLower() -notmatch $exclude.ToLower() -and $_.FileType -eq "zip" }

	}

}
