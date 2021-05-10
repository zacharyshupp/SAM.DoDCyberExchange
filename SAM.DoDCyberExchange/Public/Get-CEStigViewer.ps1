function Get-CEStigViewer {

	<#
		.SYNOPSIS
			Get Current STIGViewer Published.

		.DESCRIPTION
			Get-Current STIGViewer Published. DISA has produced standalone versions of STIG Viewer for the Windows, Linux, and macOS platforms on 64-bit x86 processors. With the end of free support for Java 8 in early 2019, Oracle Corporation changed the licensing and distribution model for Java software. Users without supported Java 8 SE environments should use the standalone versions of STIG Viewer. Users with supported Java 8 SE environments may still use the current JAR file.


		.EXAMPLE
			PS C:\> Get-CEStigViewer

			This example demonstrates how to pull the current STIGViewer for DoD Cyber Exchange.

			Name      : STIG Viewer 2.14
			URI       : https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_STIGViewer_2-14.zip
			FileName  : U_STIGViewer_2-14.zip
			FileType  : zip
			Size      : 712.99 KB
			Published : 22 Apr 2021
			Message   :

		.EXAMPLE
			PS C:\> Get-CEStigViewer -Type All -IncludeUserGuide | Save-CEItem -Destination C:\Temp

			This example demonstrates how to pull all types along with the StigViewer User Guide. Once the list is pulled its passed to Save-CEItem to download the files.
	#>

	[CmdletBinding()]
	[OutputType([System.Management.Automation.PSCustomObject])]
	param (

		# Specify the STIGViewer Type to download. Default is the Java version. If Java is not installed on the end devices then select either Windows, Mac, or Linux. These distributions have java packaged with them so there is not need to install java. If you require all versions select all.
		[Parameter()]
		[ValidateSet('Windows', 'Linux', 'Mac', 'All', "Java")]
		[String]
		$Type = "Java",

		# Specify if the user guides should be downloaded as well.
		[Parameter()]
		[Switch]
		$IncludeUserGuide,

		# Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc. Using this parameter is not secure and is not recommended. This switch is only intended to be used against known hosts using a self-signed certificate for testing purposes or a trusted website with an expired certificate. Use at your own risk.
		[Parameter()]
		[Switch]
		$SkipCertificateCheck

	)

	end {

		$items = @()

		$params = @{ Section = 'STIGTools' }
		if ($PSBoundParameters.SkipCertificateCheck) { $params.add('SkipCertificateCheck', $true) }

		$files = Get-CEItem @params

		switch ($Type) {
			"Java"    { $items += $files | Where-Object { $_.FileName -match "U_STIGViewer_\d{1,2}-\d{1,2}.zip" }}
			"Windows" { $items += $files | Where-Object { $_.FileName -match "U_STIGViewer_\d{1,2}-\d{1,2}_Win64.zip" }}
			"Mac"     { $items += $files | Where-Object { $_.FileName -match "U_STIGViewer_\d{1,2}-\d{1,2}_Mac.zip" }}
			"Linux"   { $items += $files | Where-Object { $_.FileName -match "U_STIGViewer_\d{1,2}-\d{1,2}_Linux.zip" }}
			"All"     { $items += $files | Where-Object { $_.FileName -match "U_STIGViewer_\d{1,2}-\d{1,2}(|_Linux|_Mac|_Win64).zip"}}
		}

		if ($IncludeUserGuide) {
			$items += $files | Where-Object { $_.FileName -match "U_STIG_Viewer_2-x_User_Guide_V\d{1,2}R\d{1,2}.pdf" }
		}

		Write-Output $items

	}

}
