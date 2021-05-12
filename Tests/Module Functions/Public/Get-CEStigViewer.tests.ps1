BeforeAll {

	$moduleName = $env:SAMProjectName
	$projectRoot = $env:SAMProjectPath
	$prjBuildOutputPath = Join-Path -Path $projectRoot -ChildPath "BuildOutput"
	$mdlPath = Join-Path -Path $prjBuildOutputPath -ChildPath $moduleName

	Import-Module $mdlPath -Force

}

Describe "Get-CEStigViewer" {

	It "Should return the Java version" {
		$item = Get-CEStigViewer
		$item.FileName | Should -Match "U_STIGViewer_\d{1,2}-\d{1,2}.zip"
	}

	It "Should return the Windows version" {
		$item = Get-CEStigViewer -Type Windows
		$item.FileName | Should -Match "U_STIGViewer_\d{1,2}-\d{1,2}_Win64.zip"
	}

	It "Should return the Linux version" {
		$item = Get-CEStigViewer -Type Linux
		$item.FileName | Should -Match "U_STIGViewer_\d{1,2}-\d{1,2}_Linux.zip"
	}

	It "Should return the Mac version" {
		$item = Get-CEStigViewer -Type Mac
		$item.FileName | Should -Match "U_STIGViewer_\d{1,2}-\d{1,2}_Mac.zip"
	}

	It "Should return all 4 Types (Java,Win,Linux,Mac)" {
		$item = Get-CEStigViewer -Type All
		$item.count | Should -be 4
		$item.FileName | Should -Match "U_STIGViewer_\d{1,2}-\d{1,2}(|_Linux|_Mac|_Win64).zip"
	}

	It "Should return the Java version and the User Guide" {
		$item = Get-CEStigViewer -IncludeUserGuide -SkipCertificateCheck
		$item.count | Should -be 2
		$item.FileName | Should -Match "U_STIG_Viewer_2-x_User_Guide_V\d{1,2}R\d{1,2}.pdf|U_STIGViewer_\d{1,2}-\d{1,2}(|_Linux|_Mac|_Win64).zip"
	}

}
