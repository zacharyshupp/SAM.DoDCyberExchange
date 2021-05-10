BeforeAll {

	$moduleName = $env:SAMProjectName
	$projectRoot = $env:SAMProjectPath
	$prjBuildOutputPath = Join-Path -Path $projectRoot -ChildPath "BuildOutput"
	$mdlPath = Join-Path -Path $prjBuildOutputPath -ChildPath $moduleName

	Import-Module $mdlPath -Force

}

Describe "Save-CEItem" {

	It "Should save a file" {
		$item = Get-CEComplianceChecker -OtherFiles Readme -SkipCertificateCheck
		$item | Save-CEItem -Destination $TestDrive -SkipCertificateCheck

		$filePath = Join-Path -Path $TestDrive -ChildPath $item.FileName

		Test-Path -Path $filePath | Should -be $true
	}

}
