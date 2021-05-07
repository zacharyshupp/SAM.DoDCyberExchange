<#
	.SYNOPSIS
		Module Build wrapper for SAM.DoDCyberExchange

	.NOTES
		Change Log:
			1.0.0 - 5/1/2021 (Zachary Shupp)

	.LINK
		https://github.com/zacharyshupp/SAM.DoDCyberExchange
#>

# [Script Parameters] ---------------------------------------------------------------------------------------------

[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
	'PSUseDeclaredVarsMoreThanAssignments', '',
	Justification = 'Several Parameters are used in the .\build\module.tasks.ps1 file.'
)]
param (

	# Specifies if the Dependencies should be installed.
	[Parameter()]
	[switch]
	$InstallDependencies,

	# Specifies the powershell gallery to use.
	[Parameter()]
	[string]
	$GalleryRepository = "PSGallery",

	# Specifies the Tasks to run.
	[Parameter()]
	[ValidateSet(
		"Analyze",
        "Build",
		"Clean",
		"GenerateMarkdownHelp",
		"NewFunction",
		"SetEnvironment",
        "Test"
    )]
	[string[]]
	$Task,

	# Specify if a task should override an item.
	[Parameter()]
	[Switch]
	$Force,

	# Specify the name of the new function to create.
	[Parameter()]
	[String]
	$Function,

	# Specify the type of function to create. Default value is Public.
	[Parameter()]
	[String]
	$FunctionType = "Public"

)

# [Initialisations] -----------------------------------------------------------------------------------------------

$ErrorActionPreference = 'Stop'

#Add TLS 1.2 to potential security protocols on Windows Powershell. This is now required for powershell gallery
if ($PSEdition -eq 'Desktop') {
	[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 'Tls12'
}

# [Declarations] --------------------------------------------------------------------------------------------------

$requiredModules = @{
	Pester           = 'Latest'
	InvokeBuild      = 'Latest'
	BuildHelpers     = 'Latest'
	PSScriptAnalyzer = 'Latest'
	PlatyPS          = 'Latest'
}

$moduleParams = @{
	ModuleName       = "SAM.DoDCyberExchange"
	Guid             = "bf75592f-82c7-4170-ab11-2e5425bc62b2"
	Author           = "Zachary Shupp"
	Description      = "SAM.DoDCyberExchange is a PowerShell module to interact with DoD Cyber Exchange."
	ProjectUri       = "https://github.com/zacharyshupp/SAM.DoDCyberExchange"
	LicenseUri       = "https://github.com/zacharyshupp/SAM.DoDCyberExchange/blob/main/LICENSE"
	IconUri          = "https://github.com/zacharyshupp/SAM.DoDCyberExchange/blob/main/Docs/Images/cyber-exchange.png"
	Tags             = @('SAM', 'DISA', 'STIG')
	FormatsToProcess = @()
}

# Project Directories
$prjRoot = $PSScriptRoot
$prjBuildPath = Join-Path -Path $prjRoot -ChildPath "Build"
$prjTemplatePath = Join-Path -Path $prjBuildPath -ChildPath "Templates"
$prjBuildOutputPath = Join-Path -Path $prjRoot -ChildPath "BuildOutput"
$prjBuildDependenciesPath = Join-Path -Path $prjRoot -ChildPath "BuildDependencies"
$prjDocsPath = Join-Path -Path $prjRoot -ChildPath "Docs"
$prjDocsModulePath = Join-Path -Path $prjDocsPath -ChildPath "ModuleHelp"
$prjSourcePath = Join-Path -Path $prjRoot -ChildPath $moduleParams.ModuleName
$prjLibPath = Join-Path -Path $prjSourcePath -ChildPath "Libraries"
$prjTestPath = Join-Path -Path $prjRoot -ChildPath "Tests"
$prjDotNetPath = Join-Path -Path $prjRoot -ChildPath ".config"

# Project Files
$prjBuildTaskPath = Join-Path -Path $prjBuildPath -ChildPath "build.tasks.ps1"
$prjScriptAnalyzerPath = Join-Path -Path $prjBuildPath -ChildPath "PSScriptAnalyzerSettings.psd1"
$prjBuildFunctionsPath = Join-Path -Path $prjBuildPath -ChildPath "build.functions.ps1"
$prjDotNetConfigPath = Join-Path -Path $prjDotNetPath -ChildPath "dotnet-tools.json"
$prjModuleMarkdownPath = Join-Path -Path $prjDocsPath -ChildPath "$($moduleParams.ModuleName)`.md"

# Module Build Variables
$mdlPath = Join-Path -Path $prjBuildOutputPath -ChildPath $moduleParams.ModuleName
$mdlPSM1Path = Join-Path -Path $mdlPath -ChildPath "$($moduleParams.ModuleName)`.psm1"
$mdlPSD1Path = Join-Path -Path $mdlPath -ChildPath "$($moduleParams.ModuleName)`.psd1"

# [Execution] -----------------------------------------------------------------------------------------------------

if ($InstallDependencies) {

	# Remove Dependecies directory if it already exists.
	if ((Test-Path -Path $prjBuildDependenciesPath) -eq $true) {
		Remove-Item -Path $prjBuildDependenciesPath -Recurse -Force -Confirm:$false
	}

	# Find Gallery
	$gallery = Get-PSRepository -Name $GalleryRepository

	if ($gallery -and $gallery.InstallationPolicy -eq "Untrusted") {
		Set-PSRepository -Name $GalleryRepository -InstallationPolicy Trusted
	}
	elseif (!$gallery) {
		throw "Unable to find a PSRepository with the name '$GalleryRepository'"
	}

	# Save Modules
	$requiredModules.GetEnumerator() | ForEach-Object {

		Write-Verbose "Found '$($_.Key)' with a value of '$($_.Value)'"

		$galleryParams = @{
			Name        = $_.Key
			Force       = $true
			Path        = $prjBuildDependenciesPath
			ErrorAction = 'Stop'
		}

		if ($_.Value -ne 'Latest') { $gallaryParams.Add('RequiredVersion', $_.Value) }

		Save-Module @galleryParams

	}

	# If Gallery was orginally Untrusted set back.
	if ($gallery -and $gallery.InstallationPolicy -eq "Untrusted") {
		Set-PSRepository -Name $GalleryRepository -InstallationPolicy Untrusted
	}

	# Restore DotNet Tools Restore
	if (Test-Path $prjDotNetConfigPath) { dotnet tool restore }

}

if ($Task) {

	# Import InvokeBuild Module
	if (!(Get-Module -Name "InvokeBuild")) {

		$ibModulePath = Join-Path -Path $prjBuildDependenciesPath -ChildPath "InvokeBuild"
		Import-Module $ibModulePath -Global -ErrorAction Stop

	}

	# Invoke Build Tasks
	Invoke-Build -Result 'Result' -File $prjBuildTaskPath -Task $Task

	# Return error to CI
	if ($Result.Error) {

		$Error[-1].ScriptStackTrace | Out-String
		exit 1

	}

	exit 0

}
