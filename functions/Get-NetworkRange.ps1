function Get-NetworkRange {
    # .SYNOPSIS
    #   Get a list of IP addresses within the specified network.
    # .DESCRIPTION
    #   Get-NetworkRange finds the network and broadcast address as decimal values then starts a counter between the two, returning IPAddress for each.
    # .PARAMETER IPAddress
    #   Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
    # .PARAMETER SubnetMask
    #   A subnet mask as an IP address.
    # .INPUTS
    #   System.Net.IPAddress
    #   System.String
    # .OUTPUTS
    #   System.Net.IPAddress[]
    # .EXAMPLE
    #   Get-NetworkRange 192.168.0.0 255.255.255.0
    #
    #   Returns all IP addresses in the range 192.168.0.0/24.
    # .EXAMPLE
    #   Get-NetworkRange 10.0.8.0/22
    #
    #   Returns all IP addresses in the range 192.168.0.0 255.255.252.0.
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     07/03/2016 - Chris Dent - Cleaned up code, added tests.
    #     13/10/2011 - Chris Dent - Created.

    [OutputType([System.Net.IPAddress[]])]
    param(
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [String]$IPAddress,

        [Parameter(Position = 2)]
        [String]$SubnetMask,
        
        [Switch]$IncludeNetworkAndBroadcast
    )

    process {
        $null = $psboundparameters.Remove('IncludeNetworkAndBroadcast')
        try {
            $Network = ConvertToNetwork @psboundparameters
        } catch {
            throw $_
        }
    
        $DecimalIP = ConvertTo-DecimalIP $Network.IPAddress
        $DecimalMask = ConvertTo-DecimalIP $Network.SubnetMask
    
        $DecimalNetwork = $DecimalIP -band $DecimalMask
        $DecimalBroadcast = $DecimalIP -bor ((-bnot $DecimalMask) -band [UInt32]::MaxValue)

        if (-not $IncludeNetworkAndBroadcast) {
            $DecimalNetwork += 1
            $DecimalBroadcast -= 1
        }

        for ($i = $DecimalNetwork; $i -le $DecimalBroadcast; $i++) {
            ConvertTo-DottedDecimalIP $i
        }
    }
}