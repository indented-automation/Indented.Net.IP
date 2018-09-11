---
external help file: Indented.Net.IP-help.xml
online version: 
schema: 2.0.0
---

# Get-NetworkSummary

## SYNOPSIS
Generates a summary describing several properties of a network range

## SYNTAX

```
Get-NetworkSummary [-IPAddress] <String> [[-SubnetMask] <String>]
```

## DESCRIPTION
Get-NetworkSummary uses many of the IP conversion commands to provide a summary of a network range from any IP address in the range and a subnet mask.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-NetworkSummary 192.168.0.1 255.255.255.0
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-NetworkSummary 10.0.9.43/22
```

### -------------------------- EXAMPLE 3 --------------------------
```
Get-NetworkSummary 0/0
```

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

## INPUTS

### System.String

## OUTPUTS

### Indented.Net.IP.NetworkSummary

## NOTES

## RELATED LINKS

