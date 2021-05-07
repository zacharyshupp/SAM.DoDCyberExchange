function Import-HtmlAgilityPack {

	<#
		.SYNOPSIS
			Imports HtmlAgilityPack Assembly

		.DESCRIPTION
			Checks to see if HtmlAgilityPack is loaded and if not it imports the Assembly. This function is not ment to be call by a user, its best to call this function in the begin block.

		.LINK
			https://html-agility-pack.net

		.EXAMPLE

			Begin{
				Import-HtmlAgilityPack
			}

			This example shows how the private function can be used within functions that require the HtmlAgilityPack.

	#>

	[CmdletBinding()]
	[OutputType([System.Void])]
	param ()

	# Added to support Pester Testing of Private functions
	if ($MyInvocation.MyCommand.Module) {
		$dllPath = $SAMHtmlAgilityPackDllPath
	}
	else {

		$rootPath = Split-Path -Path $PSScriptRoot -Parent
		$dllPath = [IO.Path]::Combine("$rootPath", 'Libraries', 'HTMLAgilityPack', 'Net45', 'HtmlAgilityPack.dll')
	}

	$assemblies = [System.AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.Location }

	if ($assemblies.locations -notcontains $dllPath) { Add-Type -Path $dllPath }

}
