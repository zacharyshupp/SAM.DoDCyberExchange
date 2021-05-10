BeforeAll {

	$moduleName = $env:SAMProjectName
	$projectRoot = $env:SAMProjectPath
	$prjBuildOutputPath = Join-Path -Path $projectRoot -ChildPath "BuildOutput"
	$mdlPath = Join-Path -Path $prjBuildOutputPath -ChildPath $moduleName

	Import-Module $mdlPath -Force

}

Describe "Get-CEItem" {

	It "Should be able to query the Document Library section" {
		$links = Get-CEItem -SkipCertificateCheck
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the GPO section" {
		$links = Get-CEItem -Section GPOs -SkipCertificateCheck
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the SCAP section" {
		$links = Get-CEItem -Section SCAPs -SkipCertificateCheck
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the STIG/SRG Tools section" {
		$links = Get-CEItem -Section STIGTools -SkipCertificateCheck
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the Compilations section" {
		$links = Get-CEItem -Section Compilations -SkipCertificateCheck
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the Automation section" {
		$links = Get-CEItem -Section Automation -SkipCertificateCheck
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the CCI section" {
		$links = Get-CEItem -Section CCI -SkipCertificateCheck
		$links | Should -Not -BeNullOrEmpty
	}

	It "Should be able to query the Sunset section" {
		$links = Get-CEItem -Section Sunset -SkipCertificateCheck
		$links | Should -Not -BeNullOrEmpty
	}

}
