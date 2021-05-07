---
external help file: SAM.DoDCyberExchange-help.xml
Module Name: SAM.DoDCyberExchange
online version:
schema: 2.0.0
---

# Get-CEStigViewer

## SYNOPSIS
Get Current STIGViewer Published.

## SYNTAX

```
Get-CEStigViewer [[-Type] <String>] [-IncludeUserGuide] [<CommonParameters>]
```

## DESCRIPTION
Get-Current STIGViewer Published.
DISA has produced standalone versions of STIG Viewer for the Windows, Linux, and macOS platforms on 64-bit x86 processors.
With the end of free support for Java 8 in early 2019, Oracle Corporation changed the licensing and distribution model for Java software.
Users without supported Java 8 SE environments should use the standalone versions of STIG Viewer.
Users with supported Java 8 SE environments may still use the current JAR file.

## EXAMPLES

### EXAMPLE 1
```
Get-CEStigViewer
```

This example demonstratess how to pull the curent STIGViewer for DoD Cyber Exchange.

Name      : STIG Viewer 2.14
URI       : https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_STIGViewer_2-14.zip
FileName  : U_STIGViewer_2-14.zip
FileType  : zip
Size      : 712.99 KB
Published : 22 Apr 2021
Message   :

### EXAMPLE 2
```
Get-CEStigViewer -Type All -IncludeUserGuide | Save-CEItem -Destination C:\Temp
```

This example demonstrates how to pull all types along with the StigViewer User Guide.
Once the list is pulled its passsed to Save-CEItem to download the files.

## PARAMETERS

### -IncludeUserGuide
Specify if the user guides should be downloaded as well.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Specify the STIGViewer Type to download.
Default is the Java version.
If Java is not installed on the end devices then select either Windows, Mac, or Linux.
These distributions have java packaged with them so there is not need to install java.
If you require all versions select all.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Java
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
