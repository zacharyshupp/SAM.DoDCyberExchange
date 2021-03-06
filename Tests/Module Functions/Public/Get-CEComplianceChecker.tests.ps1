BeforeAll {

	$moduleName = $env:SAMProjectName
	$projectRoot = $env:SAMProjectPath
	$prjBuildOutputPath = Join-Path -Path $projectRoot -ChildPath "BuildOutput"
	$mdlPath = Join-Path -Path $prjBuildOutputPath -ChildPath $moduleName

	Import-Module $mdlPath -Force

}

Describe "Get-CEComplianceChecker" {

	It "Should return the Windows SCC" {
		$item = Get-CEComplianceChecker -Type Windows -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc-\d.\d_windows"
	}

	It "Should return the Redhat SCC" {
		$item = Get-CEComplianceChecker -Type Redhat -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc-\d.\d_rhel"
	}

	It "Should return the Ubuntu SCC" {
		$item = Get-CEComplianceChecker -Type Ubuntu -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc-\d.\d_ubuntu"
	}

	It "Should return the Mac SCC" {
		$item = Get-CEComplianceChecker -Type Mac -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc-\d.\d_mac"
	}

	It "Should return the Solaris SCC" {
		$item = Get-CEComplianceChecker -Type Solaris -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc-\d.\d_solaris"
	}

	It "Should return the Raspbian SCC" {
		$item = Get-CEComplianceChecker -Type Raspbian -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc-\d.\d_raspbian"
	}

	It "Should return all SCC types" {
		$item = Get-CEComplianceChecker -Type Raspbian -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc-\d.\d_(windows|ubuntu|rhel|mac|raspbian|sol)"
	}

	It "Should return the UnlockerBundle" {
		$item = Get-CEComplianceChecker -OtherFiles UnlockerBundle -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc(-|_)\d.\d_unlocker"
	}

	It "Should return the Checksums" {
		$item = Get-CEComplianceChecker -OtherFiles Checksums -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc(-|_)\d.\d_checksums"
	}

	It "Should return the UnixRemoteScanningPlugin" {
		$item = Get-CEComplianceChecker -OtherFiles UnixRemoteScanningPlugin -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc(-|_)\d.\d_unix_remote"
	}

	It "Should return the ReleaseNotes" {
		$item = Get-CEComplianceChecker -OtherFiles ReleaseNotes -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc(-|_)\d.\d_releasenotes"
	}

	It "Should return the Readme" {
		$item = Get-CEComplianceChecker -OtherFiles Readme -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc(-|_)\d.\d_readme"
	}

	It "Should return the RPM-GPG-KEY" {
		$item = Get-CEComplianceChecker -OtherFiles RPM-GPG-KEY -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^rpm-gpg-key-scc"
	}

	It "Should return all the Other files" {
		$item = Get-CEComplianceChecker -OtherFiles All -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^rpm-gpg-key-scc|^scc(-|_)\d.\d_(unlocker|checksums|unix_remote|releasenotes|readme)"
	}

	It "Should return all SCC packages along with all the Other Files" {
		$item = Get-CEComplianceChecker -Type All -OtherFiles All -SkipCertificateCheck
		$item.FileName.ToLower() | Should -Match "^scc-\d.\d_(windows|ubuntu|rhel|mac|raspbian|sol)|^rpm-gpg-key-scc|^scc(-|_)\d.\d_(unlocker|checksums|unix_remote|releasenotes|readme)"
	}

}
