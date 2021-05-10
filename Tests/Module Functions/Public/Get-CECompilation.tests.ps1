BeforeAll {

	$moduleName = $env:SAMProjectName
	$projectRoot = $env:SAMProjectPath
	$prjBuildOutputPath = Join-Path -Path $projectRoot -ChildPath "BuildOutput"
	$mdlPath = Join-Path -Path $prjBuildOutputPath -ChildPath $moduleName

	Import-Module $mdlPath -Force

}

Describe "Get-CECompilation" {

	It "Should return a single Compilation" {
		$item = Get-CECompilation -SkipCertificateCheck
		$item.count | Should -eq 1
		$item.FileName.ToLower() | Should -Match "^u_srg-stig_library"
	}

}
