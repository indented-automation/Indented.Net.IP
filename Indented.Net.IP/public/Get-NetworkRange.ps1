filter Get-NetworkRange {
    <#
    .SYNOPSIS
        Get a list of IP addresses within the specified network.
    .DESCRIPTION
        Get-NetworkRange finds the network and broadcast address as decimal values then starts a counter between the two, returning IPAddress for each.
    .INPUTS
        System.String
    .OUTPUTS
        System.Net.IPAddress
    .EXAMPLE
        Get-NetworkRange 192.168.0.0 255.255.255.0
        
        Returns all IP addresses in the range 192.168.0.0/24.
    .EXAMPLE
        Get-NetworkRange 10.0.8.0/22
        
        Returns all IP addresses in the range 192.168.0.0 255.255.252.0.
    .NOTES
        Change log:
            07/09/2017 - Chris Dent - Converted to filter.
            07/03/2016 - Chris Dent - Cleaned up code, added tests.
            13/10/2011 - Chris Dent - Created.
    #>

    [CmdletBinding()]
    [OutputType([System.Net.IPAddress])]
    param (
        # Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [String]$IPAddress,

        # A subnet mask as an IP address.
        [Parameter(Position = 2)]
        [String]$SubnetMask,
        
        # Include the network and broadcast addresses when generating a network address range.
        [Switch]$IncludeNetworkAndBroadcast
    )

    $null = $psboundparameters.Remove('IncludeNetworkAndBroadcast')
    try {
        $network = ConvertToNetwork @psboundparameters
    } catch {
        $pscmdlet.ThrowTerminatingError($_)
    }

    $decimalIP = ConvertTo-DecimalIP $network.IPAddress
    $decimalMask = ConvertTo-DecimalIP $network.SubnetMask

    $decimalNetwork = $decimalIP -band $decimalMask
    $decimalBroadcast = $decimalIP -bor (-bnot $decimalMask -band [UInt32]::MaxValue)

    if (-not $IncludeNetworkAndBroadcast) {
        $decimalNetwork += 1
        $decimalBroadcast -= 1
    }

    for ($i = $decimalNetwork; $i -le $decimalBroadcast; $i++) {
        ConvertTo-DottedDecimalIP $i
    }
}