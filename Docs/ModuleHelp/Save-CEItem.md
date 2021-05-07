---
external help file: SAM.DoDCyberExchange-help.xml
Module Name: SAM.DoDCyberExchange
online version:
schema: 2.0.0
---

# Save-CEItem

## SYNOPSIS
Save a file from Cyber Exchange

## SYNTAX

```
Save-CEItem [-Destination] <String> -URI <String[]> [<CommonParameters>]
```

## DESCRIPTION
Takes the object from Get-CEItem and saves it to a location specified.

## EXAMPLES

### EXAMPLE 1
```
Save-CEItem -Destination "C:\Temp" -URI "https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_STIGViewer_2-14.zip"
```

This example shows how to call Save-CEItem and Save a file.

### EXAMPLE 2
```
Get-CEItem -Section GPOs | Save-CEItem -Destination "C:\Temp"
```

This example shows the Get-CEItem function pulling a list of GPOs and it pipes the output to Save-CEItem to download the files.

## PARAMETERS

### -Destination
Specifies the destination to save the file to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -URI
Specifies the URL for the file to download from public.cyber.mil

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Void
## NOTES

## RELATED LINKS
