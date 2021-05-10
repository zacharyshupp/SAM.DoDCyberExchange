function Get-CEComplianceChecker {

	<#
		.SYNOPSIS
			Retrieve list of available downloads for SCAP Compliance Checker (SCC)

		.DESCRIPTION
			Retrieve list of available downloads for SCAP Compliance Checker (SCC).

		.EXAMPLE
			PS C:\> Get-CEComplianceChecker -Type Windows

			This example demonstrates how to pull the Windows SCC files from DoD Cyber Exchange.

		.EXAMPLE
			PS C:\> Get-CEComplianceChecker -Type Windows -OtherFiles Checksums

			This example demonstrates how to pull the Windows SCC files and the Checksums from DoD Cyber Exchange.

		.EXAMPLE
			PS C:\> Get-CEComplianceChecker -Type All -OtherFiles All

			This example demonstrates how to pull All SCC Installs and Support Files from DoD Cyber Exchange.
	#>

	[CmdletBinding()]
	[OutputType([System.Management.Automation.PSCustomObject])]
	param (

		# Specify the SCAP Compliance Checker (SCC) Type to download. Options are All, Windows, Redhat, Ubuntu, Mac, Solaris, and Raspbian
		[Parameter()]
		[ValidateSet('Windows', 'Redhat', 'Ubuntu', 'Mac', 'Solaris', 'Raspbian', 'All')]
		[String[]]
		$Type,

		# Specify additional support files to download. Options are Unlocker Bundle, Checksums, UnixRemoteScanningPlugin, ReleaseNotes, Readme, RPM-GPG-KEY.
		[Parameter()]
		[ValidateSet('UnlockerBundle', 'Checksums', 'UnixRemoteScanningPlugin', 'ReleaseNotes', 'Readme', 'RPM-GPG-KEY', 'All')]
		[String[]]
		$OtherFiles,

		# Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc. Using this parameter is not secure and is not recommended. This switch is only intended to be used against known hosts using a self-signed certificate for testing purposes or a trusted website with an expired certificate. Use at your own risk.
		[Parameter()]
		[Switch]
		$SkipCertificateCheck

	)

	begin {

		$items = @()

		$params = @{ Section = 'SCAPs' }

		if ($PSBoundParameters.SkipCertificateCheck) { $params.add('SkipCertificateCheck', $true) }

		$files = Get-CEItem @params

	}

	process {

		$items += $Type | ForEach-Object {

			switch ($_) {
				'Windows' { $files | Where-Object { $_.FileName.ToLower() -match "^scc-\d.\d_windows" } }
				'Redhat' { $files | Where-Object { $_.FileName.ToLower() -match "^scc-\d.\d_rhel" } }
				'Ubuntu' { $files | Where-Object { $_.FileName.ToLower() -match "^scc-\d.\d_ubuntu" } }
				'Mac' { $files | Where-Object { $_.FileName.ToLower() -match "^scc-\d.\d_mac" } }
				'Solaris' { $files | Where-Object { $_.FileName.ToLower() -match "^scc-\d.\d_solaris" } }
				'Raspbian' { $files | Where-Object { $_.FileName.ToLower() -match "^scc-\d.\d_raspbian" } }
				'All' { $files | Where-Object { $_.FileName.ToLower() -match "^scc-\d.\d_(windows|ubuntu|rhel|mac|raspbian|sol)" } }
			}

		}

	}

	end {

		$items += $OtherFiles | ForEach-Object {

			switch ($_) {
				'UnlockerBundle' { $files | Where-Object { $_.FileName.ToLower() -match "^scc(-|_)\d.\d_unlocker" } }
				'Checksums' { $files | Where-Object { $_.FileName.ToLower() -match "^scc(-|_)\d.\d_checksums" } }
				'UnixRemoteScanningPlugin' { $files | Where-Object { $_.FileName.ToLower() -match "^scc(-|_)\d.\d_unix_remote" } }
				'ReleaseNotes' { $files | Where-Object { $_.FileName.ToLower() -match "^scc(-|_)\d.\d_releasenotes" } }
				'Readme' { $files | Where-Object { $_.FileName.ToLower() -match "^scc(-|_)\d.\d_readme" } }
				'RPM-GPG-KEY' { $files | Where-Object { $_.FileName.ToLower() -match "^rpm-gpg-key-scc" } }
				'All' { $files | Where-Object { $_.FileName.ToLower() -match "^rpm-gpg-key-scc|^scc(-|_)\d.\d_(unlocker|checksums|unix_remote|releasenotes|readme)" } }
			}

		}

		Write-Output $items

	}

}
