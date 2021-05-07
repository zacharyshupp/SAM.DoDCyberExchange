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
	param ()

	end {

		Get-CEItem -Section DocumentLibrary |
			Where-Object { $_.FileType -eq "zip" -and $_.FileName -Like "*_Benchmark.zip" }

	}

}
