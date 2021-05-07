---
external help file: SAM.DoDCyberExchange-help.xml
Module Name: SAM.DoDCyberExchange
online version:
schema: 2.0.0
---

# Get-CEItem

## SYNOPSIS
Retrieve list of all files from a specific Cyber Exchange URL.

## SYNTAX

```
Get-CEItem [[-Section] <String>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve list of all files from a specific Cyber Exchange URL.
The function calls the URL and looks for any tables on the page that would list files.
This function only works with the public.cyber.mil website, for items that require a CAC to download you will have to log in via the web browser and download manually.

Useful URLS
- Document Library: <https://public.cyber.mil/stigs/downloads/>
- SCAPs:            <https://public.cyber.mil/stigs/scap/>
- STIG/SRG Tools:   <https://public.cyber.mil/stigs/srg-stig-tools/>
- Compilations:     <https://public.cyber.mil/stigs/compilations/>
- GPOs:             <https://public.cyber.mil/stigs/gpo/>
- Automation:       <https://public.cyber.mil/stigs/supplemental-automation-content/>
- CCI:              <https://public.cyber.mil/stigs/cci/>
- Sunset:           <https://public.cyber.mil/stigs/sunset-products/c=>

## EXAMPLES

### EXAMPLE 1
```
Get-CEItem
```

This example demonstrates how to call the function in its default configuration.
When called by itself, the function will query the downloads section of DoD Cyber Exchange.

### EXAMPLE 2
```
Get-CEItem -Section compilations
```

This example demonstrates how to pull the STIG compilations for DoD Cyber Exchange.

## PARAMETERS

### -Section
Specify the Cyber.Mil Site Section to retrieve file list from.
The default value is 'DocumentLibrary' which is the main list of items to download.
Other options are "SCAPs","STIGTools","Compilations","GPOs","Automation","CCI","Sunset".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: DocumentLibrary
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
