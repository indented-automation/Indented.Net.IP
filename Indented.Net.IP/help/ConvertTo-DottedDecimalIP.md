---
external help file: Indented.Net.IP-help.xml
online version: 
schema: 2.0.0
---

# ConvertTo-DottedDecimalIP

## SYNOPSIS
Converts either an unsigned 32-bit integer or a dotted binary string to an IP Address.

## SYNTAX

```
ConvertTo-DottedDecimalIP [-IPAddress] <String>
```

## DESCRIPTION
ConvertTo-DottedDecimalIP uses a regular expression match on the input string to convert to an IP address.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
ConvertTo-DottedDecimalIP 11000000.10101000.00000000.00000001
```

Convert the binary form back to dotted decimal, resulting in 192.168.0.1.

### -------------------------- EXAMPLE 2 --------------------------
```
ConvertTo-DottedDecimalIP 3232235521
```

Convert the decimal form back to dotted decimal, resulting in 192.168.0.1.

## PARAMETERS

### -IPAddress
A string representation of an IP address from either UInt32 or dotted binary.

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
Change log:
    07/09/2017 - Chris Dent - Converted to filter.
    06/03/2016 - Chris Dent - Cleaned up code, added tests.
    25/11/2010 - Chris Dent - Created.

## RELATED LINKS

