# SAM.DoDCyberExchange

SAM.DoDCyberExchange is a PowerShell module to interact with DoD Cyber Exchange.

| Function                     | Description                                                                                                                              |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| [Get-CEItem][3]              | Retrieve list of all files from a specific Cyber Exchange URL.                                                                           |
| [Get-CECompilation][0]       | Get current STIG Compilation from public.cyber.mil                                                                                       |
| [Get-CEComplianceChecker][2] | Retrieve list of available downloads for SCAP Compliance Checker (SCC).                                                                  |
| [Get-CEScapBenchmark][4]     | Retrieves a list of SCAP Benchmarks from Cyber.mil using the Get-CEItem function.                                                        |
| [Get-CEStig][1]              | Retrieves a list of STIG/SRG List from public.cyber.mil using the Get-CEItem function. This function also includes all the Sunset STIGs. |
| [Get-CEStigViewer][5]        | Get-Current STIGViewer Published.                                                                                                        |
| [Save-CEItem][6]             | Takes the object from Get-CEItem and saves it to a location specified.                                                                   |
|                              |                                                                                                                                          |

## Installation

### Option A: Download from PowerShell Gallery

```PowerShell
Install-Module -Name SAM.DoDCyberExchange
```

### Option B: Manual Download from GitHub

1. Download the repository
2. Unblock Zip File before extracting
3. Extract the zip file to any directory
4. Run `.\build.ps1 -InstallDependencies -Task Build` (exists in project root)
5. `build.ps1` creates a folder called `~\BuildOutput\SAM.DoDCyberExchange` in the directory which `SAM.DoDCyberExchange` was saved to.
6. Run `Import-Module -Path "C:\Path\To\buildoutput\SAM.DoDCyberExchange"` to import module

## Aditional Items

[Contributing][7]

## Resources

Below are links to useful resources.

- [Cyber.mil (Public Access)](https://public.cyber.mil)
- [Cyber.mil (CAC Required)](https://cyber.mil)

[0]: Docs\ModuleHelp\Get-CECompilation.md
[1]: Docs\ModuleHelp\Get-CEStig.md
[2]: Docs\ModuleHelp\Get-CEComplianceChecker.md
[3]: Docs\ModuleHelp\Get-CEItem.md
[4]: Docs\ModuleHelp\Get-CEScapBenchmark.md
[5]: Docs\ModuleHelp\Get-CEStigViewer.md
[6]: Docs\ModuleHelp\Save-CEItem.md
[7]: Docs\contributing.md
