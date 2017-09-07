filter Get-BroadcastAddress {
    <#
    .SYNOPSIS
        Get the broadcast address for a network range.
    .DESCRIPTION
        Get-BroadcastAddress returns the broadcast address for a subnet by performing a bitwise AND operation against the decimal forms of the IP address and inverted subnet mask.
    .INPUTS
        System.String
    .EXAMPLE
        Get-BroadcastAddress 192.168.0.243 255.255.255.0
      
        Returns the address 192.168.0.255.
    .EXAMPLE
        Get-BroadcastAddress 10.0.9/22
      
        Returns the address 10.0.11.255.
    .EXAMPLE
        Get-BroadcastAddress 0/0
    
        Returns the address 255.255.255.255.
    .EXAMPLE
        Get-BroadcastAddress "10.0.0.42 255.255.255.252"
    
        Input values are automatically split into IP address and subnet mask. Returns the address 10.0.0.43.
    .NOTES
        Change log:
            07/09/2017 - Chris Dent - Converted to filter.
            06/03/2016 - Chris Dent - Cleaned up code, added tests.
            25/11/2010 - Chris Dent - Created.
    #>
    
    [CmdletBinding()]
    [OutputType([System.Net.IPAddress])]
    param (
        # Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [String]$IPAddress,

        # A subnet mask as an IP address.
        [Parameter(Position = 2)]
        [String]$SubnetMask
    )

    try {
        $network = ConvertToNetwork @psboundparameters
        $decimalIP = ConvertTo-DecimalIP $network.IPAddress
        $invertedMask = -bnot (ConvertTo-DecimalIP $network.SubnetMask) -band [UInt32]::MaxValue

        ConvertTo-DottedDecimalIP ($decimalIP -bor $invertedMask)
    } catch {
        $pscmdlet.ThrowTerminatingError($_)
    }
}