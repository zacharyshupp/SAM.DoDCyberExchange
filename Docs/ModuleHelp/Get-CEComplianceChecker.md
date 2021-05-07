---
external help file: SAM.DoDCyberExchange-help.xml
Module Name: SAM.DoDCyberExchange
online version:
schema: 2.0.0
---

# Get-CEComplianceChecker

## SYNOPSIS
Retrieve list of available downloads for SCAP Compliance Checker (SCC)

## SYNTAX

```
Get-CEComplianceChecker [[-Type] <String[]>] [[-OtherFiles] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve list of available downloads for SCAP Compliance Checker (SCC).

## EXAMPLES

### EXAMPLE 1
```
Get-CEComplianceChecker -Type Windows
```

This example demonstrates how to pull the Windows SCC files from DoD Cyber Exchange.

### EXAMPLE 2
```
Get-CEComplianceChecker -Type Windows -OtherFiles Checksums
```

This example demonstrates how to pull the Windows SCC files and the Checksums from DoD Cyber Exchange.

### EXAMPLE 3
```
Get-CEComplianceChecker -Type All -OtherFiles All
```

This example demonstrates how to pull All SCC Installs and Support Files from DoD Cyber Exchange.

## PARAMETERS

### -OtherFiles
Specify additional support files to download.
Options are Unlocker Bundle, Checksums, UnixRemoteScanningPlugin, ReleaseNotes, Readme, RPM-GPG-KEY.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Specify the SCAP Compliance Checker (SCC) Type to download.
Options are All, Windows, Redhat, Ubuntu, Mac, Solaris, and Raspbian

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES

## RELATED LINKS
