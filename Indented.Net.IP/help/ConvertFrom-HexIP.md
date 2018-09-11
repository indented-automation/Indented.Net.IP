---
external help file: Indented.Net.IP-help.xml
online version: 
schema: 2.0.0
---

# ConvertFrom-HexIP

## SYNOPSIS
Converts a hexadecimal IP address into a dotted decimal string.

## SYNTAX

```
ConvertFrom-HexIP [-IPAddress] <String>
```

## DESCRIPTION
ConvertFrom-HexIP takes a hexadecimal string and returns a dotted decimal IP address.
An intermediate call is made to ConvertTo-DottedDecimalIP.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
ConvertFrom-HexIP c0a80001
```

Returns the IP address 192.168.0.1.

## PARAMETERS

### -IPAddress
An IP Address to convert.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.String

## OUTPUTS

### System.Net.IPAddress

## NOTES

## RELATED LINKS

