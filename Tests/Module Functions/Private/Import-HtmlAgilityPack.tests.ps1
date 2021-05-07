BeforeAll {

	$projectRoot = $env:SAMProjectPath
	$moduleName = $env:SAMProjectName
	$fctName = "Import-HtmlAgilityPack"

	$fctPath = [IO.Path]::Combine("$projectRoot", $moduleName, 'Private', "$fctName`.ps1")

	. $fctPath

}

Describe "Import-HtmlAgilityPack" {

    It "Should Load HtmlAgilityPack" {

		Import-HtmlAgilityPack

		$loadedAssemblies = [System.AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.Location }

		$loadedAssemblies | Where-Object {$_.Location -like "*HtmlAgilityPack.dll"} | Should -Not -BeNullOrEmpty

    }

}
