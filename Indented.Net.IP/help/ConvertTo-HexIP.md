---
external help file: Indented.Net.IP-help.xml
online version: 
schema: 2.0.0
---

# ConvertTo-HexIP

## SYNOPSIS
Convert a dotted decimal IP address into a hexadecimal string.

## SYNTAX

```
ConvertTo-HexIP [-IPAddress] <IPAddress>
```

## DESCRIPTION
ConvertTo-HexIP takes a dotted decimal IP and returns a single hexadecimal string value.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
ConvertTo-HexIP 192.168.0.1
```

Returns the hexadecimal string c0a80001.

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

### System.String

## NOTES

## RELATED LINKS

