---
external help file: Indented.Net.IP-help.xml
online version: 
schema: 2.0.0
---

# ConvertTo-MaskLength

## SYNOPSIS
Convert a dotted-decimal subnet mask to a mask length.

## SYNTAX

```
ConvertTo-MaskLength [-SubnetMask] <IPAddress>
```

## DESCRIPTION
A count of the number of 1's in a binary string.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
ConvertTo-MaskLength 255.255.255.0
```

Returns 24, the length of the mask in bits.

## PARAMETERS

### -SubnetMask
A subnet mask to convert into length.

```yaml
Type: IPAddress
Parameter Sets: (All)
Aliases: Mask

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.Net.IPAddress

## OUTPUTS

### System.Int32

## NOTES

## RELATED LINKS

