---
external help file: SAM.DoDCyberExchange-help.xml
Module Name: SAM.DoDCyberExchange
online version:
schema: 2.0.0
---

# Get-CEScapBenchmark

## SYNOPSIS
Retrieves a list of SCAP Benchmarks from Cyber.mil

## SYNTAX

```
Get-CEScapBenchmark [<CommonParameters>]
```

## DESCRIPTION
Retrieves a list of SCAP Benchmarks from Cyber.mil using the Get-CEItem function.

## EXAMPLES

### EXAMPLE 1
```
Get-CEScapBenchmark | Save-CEItem -Destination C:\Temp\SCAPS
```

This example shows the default method to call the function.
It pipes the output to Save-CEItem to download the file.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES

## RELATED LINKS
