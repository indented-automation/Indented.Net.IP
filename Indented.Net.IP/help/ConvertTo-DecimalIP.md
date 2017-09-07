---
external help file: Indented.Net.IP-help.xml
online version: 
schema: 2.0.0
---

# ConvertTo-DecimalIP

## SYNOPSIS
Converts a Decimal IP address into a 32-bit unsigned integer.

## SYNTAX

```
ConvertTo-DecimalIP [-IPAddress] <IPAddress>
```

## DESCRIPTION
ConvertTo-DecimalIP takes a decimal IP, uses a shift operation on each octet and returns a single UInt32 value.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
ConvertTo-DecimalIP 1.2.3.4
```

Converts an IP address to an unsigned 32-bit integer value.

## PARAMETERS

### -IPAddress
An IP Address to convert.

```yaml
Type: IPAddress
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.Net.IPAddress

## OUTPUTS

### System.UInt32

## NOTES
Change log:
    07/09/2017 - Chris Dent - Converted to filter.
    06/03/2016 - Chris Dent - Cleaned up code, added tests.
    25/11/2010 - Chris Dent - Created.

## RELATED LINKS

