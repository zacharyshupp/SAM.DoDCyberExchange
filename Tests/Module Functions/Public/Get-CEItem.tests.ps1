BeforeAll {

	$moduleName = $env:SAMProjectName
	$projectRoot = $env:SAMProjectPath
	$prjBuildOutputPath = Join-Path -Path $projectRoot -ChildPath "BuildOutput"
	$mdlPath = Join-Path -Path $prjBuildOutputPath -ChildPath $moduleName

	Import-Module $mdlPath -Force

}

Describe "Get-CEItem" {

	It "Should be able to query the Document Library section" {
		$links = Get-CEItem
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the GPO section" {
		$links = Get-CEItem -Section GPOs
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the SCAP section" {
		$links = Get-CEItem -Section SCAPs
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the STIG/SRG Tools section" {
		$links = Get-CEItem -Section STIGTools
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the Compilations section" {
		$links = Get-CEItem -Section Compilations
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the Automation section" {
		$links = Get-CEItem -Section Automation
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the CCI section" {
		$links = Get-CEItem -Section CCI
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the Sunset section" {
		$links = Get-CEItem -Section Sunset
		$links | Should -Not -BeNullOrEmpty
	}

}
