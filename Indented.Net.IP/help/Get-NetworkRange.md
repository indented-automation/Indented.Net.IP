---
external help file: Indented.Net.IP-help.xml
online version: 
schema: 2.0.0
---

# Get-NetworkRange

## SYNOPSIS
Get a list of IP addresses within the specified network.

## SYNTAX

```
Get-NetworkRange [-IPAddress] <String> [[-SubnetMask] <String>] [-IncludeNetworkAndBroadcast]
```

## DESCRIPTION
Get-NetworkRange finds the network and broadcast address as decimal values then starts a counter between the two, returning IPAddress for each.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-NetworkRange 192.168.0.0 255.255.255.0
```

Returns all IP addresses in the range 192.168.0.0/24.

### -------------------------- EXAMPLE 2 --------------------------
```
Get-NetworkRange 10.0.8.0/22
```

Returns all IP addresses in the range 192.168.0.0 255.255.252.0.

## PARAMETERS

### -IPAddress
Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.

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

### -SubnetMask
A subnet mask as an IP address.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeNetworkAndBroadcast
Include the network and broadcast addresses when generating a network address range.

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

## INPUTS

### System.String

## OUTPUTS

### System.Net.IPAddress

## NOTES
Change log:
    07/09/2017 - Chris Dent - Converted to filter.
    07/03/2016 - Chris Dent - Cleaned up code, added tests.
    13/10/2011 - Chris Dent - Created.

## RELATED LINKS

