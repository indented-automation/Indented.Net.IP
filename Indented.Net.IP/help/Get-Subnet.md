---
external help file: Indented.Net.IP-help.xml
Module Name: Indented.Net.IP
online version:
schema: 2.0.0
---

# Get-Subnet

## SYNOPSIS
Get a list of subnets of a given size within a defined supernet.

## SYNTAX

### FromSupernet (Default)
```
Get-Subnet [-IPAddress] <String> [[-SubnetMask] <String>] -NewSubnetMask <String> [<CommonParameters>]
```

### FromStartAndEnd
```
Get-Subnet -Start <IPAddress> -End <IPAddress> [<CommonParameters>]
```

## DESCRIPTION
Generates a list of subnets for a given network range using either the address class or a user-specified value.

## EXAMPLES

### EXAMPLE 1
```
Get-Subnet 10.0.0.0 255.255.255.0 -NewSubnetMask 255.255.255.192
```

Four /26 networks are returned.

### EXAMPLE 2
```
Get-Subnet 0/22 -NewSubnetMask 24
```

64 /24 networks are returned.

### EXAMPLE 3
```
Get-Subnet -Start 10.0.0.1 -End 10.0.0.16
```

Get the largest possible subnets between the start and end address.

## PARAMETERS

### -IPAddress
Any address in the super-net range.
Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.

```yaml
Type: String
Parameter Sets: FromSupernet
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubnetMask
The subnet mask of the network to split.
Mandatory if the subnet mask is not included in the IPAddress parameter.

```yaml
Type: String
Parameter Sets: FromSupernet
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewSubnetMask
Split the existing network described by the IPAddress and subnet mask using this mask.

```yaml
Type: String
Parameter Sets: FromSupernet
Aliases:

Required: True
Position: Named
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Indented.Net.IP.Subnet
## NOTES

## RELATED LINKS
