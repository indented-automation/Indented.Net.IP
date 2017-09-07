---
external help file: Indented.Net.IP-help.xml
online version: 
schema: 2.0.0
---

# ConvertTo-Subnet

## SYNOPSIS
Convert a start and end IP address to the closest matching subnet.

## SYNTAX

### FromIPAndMask (Default)
```
ConvertTo-Subnet [-IPAddress] <String> [[-SubnetMask] <String>]
```

### FromStartAndEnd
```
ConvertTo-Subnet -Start <IPAddress> -End <IPAddress>
```

## DESCRIPTION
ConvertTo-Subnet attempts to convert a starting and ending IP address from a range to the closest subnet.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
ConvertTo-Subnet -Start 0.0.0.0 -End 255.255.255.255
```

### -------------------------- EXAMPLE 2 --------------------------
```
ConvertTo-Subnet -Start 192.168.0.1 -End 192.168.0.129
```

### -------------------------- EXAMPLE 3 --------------------------
```
ConvertTo-Subnet 10.0.0.23/24
```

### -------------------------- EXAMPLE 4 --------------------------
```
ConvertTo-Subnet 10.0.0.23 255.255.255.0
```

## PARAMETERS

### -IPAddress
Any IP address in the subnet.

```yaml
Type: String
Parameter Sets: FromIPAndMask
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubnetMask
A subnet mask.

```yaml
Type: String
Parameter Sets: FromIPAndMask
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Start
The first IP address from a range.

```yaml
Type: IPAddress
Parameter Sets: FromStartAndEnd
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -End
The last IP address from a range.

```yaml
Type: IPAddress
Parameter Sets: FromStartAndEnd
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Indented.Net.IP.Subnet

## NOTES
Change log:
    06/03/2016 - Chris Dent - Cleaned up code, added tests.
    14/05/2014 - Chris Dent - Created.

## RELATED LINKS

