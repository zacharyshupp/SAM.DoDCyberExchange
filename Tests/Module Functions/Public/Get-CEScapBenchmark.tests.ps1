BeforeAll {

	$moduleName = $env:SAMProjectName
	$projectRoot = $env:SAMProjectPath
	$prjBuildOutputPath = Join-Path -Path $projectRoot -ChildPath "BuildOutput"
	$mdlPath = Join-Path -Path $prjBuildOutputPath -ChildPath $moduleName

	Import-Module $mdlPath -Force

}

Describe "Get-CEScapBenchmark" {

	It "Should return only Benchmark files" {
		$item = Get-CEScapBenchmark -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "_(B|b)enchmark.zip"
	}

}
