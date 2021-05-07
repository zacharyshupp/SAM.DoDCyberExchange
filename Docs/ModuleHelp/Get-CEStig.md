---
external help file: SAM.DoDCyberExchange-help.xml
Module Name: SAM.DoDCyberExchange
online version:
schema: 2.0.0
---

# Get-CEStig

## SYNOPSIS
Retrieves a list of STIG/SRG List from public.cyber.mil.

## SYNTAX

```
Get-CEStig [<CommonParameters>]
```

## DESCRIPTION
Retrieves a list of STIG/SRG List from public.cyber.mil using the Get-CEItem function.
This function also includes all the Sunset STIGs.

## EXAMPLES

### EXAMPLE 1
```
Get-CEStig | Save-CEItem -Destination C:\Temp\STIGs
```

This example shows the default method to call Get-CEStig.
It pipes the output to Save-CEItem to download the file.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES

## RELATED LINKS
