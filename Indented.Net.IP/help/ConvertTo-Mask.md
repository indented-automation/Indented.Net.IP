---
external help file: Indented.Net.IP-help.xml
online version: 
schema: 2.0.0
---

# ConvertTo-Mask

## SYNOPSIS
Convert a mask length to a dotted-decimal subnet mask.

## SYNTAX

```
ConvertTo-Mask [-MaskLength] <Byte>
```

## DESCRIPTION
ConvertTo-Mask returns a subnet mask in dotted decimal format from an integer value ranging between 0 and 32.

ConvertTo-Mask creates a binary string from the length, converts the string to an unsigned 32-bit integer then calls ConvertTo-DottedDecimalIP to complete the operation.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
ConvertTo-Mask 24
```

Returns the dotted-decimal form of the mask, 255.255.255.0.

## PARAMETERS

### -MaskLength
The number of bits which must be masked.

```yaml
Type: Byte
Parameter Sets: (All)
Aliases: Length

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.Int32

## OUTPUTS

### System.Net.IPAddress

## NOTES
Change log:
    07/09/2017 - Chris Dent - Converted to filter.
    06/03/2016 - Chris Dent - Cleaned up code, added tests.
    25/11/2010 - Chris Dent - Created.

## RELATED LINKS

