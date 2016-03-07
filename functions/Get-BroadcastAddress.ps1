function Get-BroadcastAddress {
    # .SYNOPSIS
    #   Get the broadcast address for a network range.
    # .DESCRIPTION
    #   Get-BroadcastAddress returns the broadcast address for a subnet by performing a bitwise AND operation against the decimal forms of the IP address and inverted subnet mask.
    # .PARAMETER IPAddress
    #   Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
    # .PARAMETER SubnetMask
    #   A subnet mask as an IP address.
    # .INPUTS
    #   System.String
    # .OUTPUTS
    #   System.Net.IPAddress
    # .EXAMPLE
    #   Get-BroadcastAddress 192.168.0.243 255.255.255.0
    #   
    #   Returns the address 192.168.0.255.
    # .EXAMPLE
    #   Get-BroadcastAddress 10.0.9/22
    #   
    #   Returns the address 10.0.11.255.
    # .EXAMPLE
    #   Get-BroadcastAddress 0/0
    #
    #   Returns the address 255.255.255.255.
    # .EXAMPLE
    #   Get-BroadcastAddress "10.0.0.42 255.255.255.252"
    #
    #   Input values are automatically split into IP address and subnet mask. Returns the address 10.0.0.43.
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     06/03/2016 - Chris Dent - Cleaned up code, added tests.
    #     25/11/2010 - Chris Dent - Created.
    
    [OutputType([System.Net.IPAddress])]
    param(
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [String]$IPAddress,

        [Parameter(Position = 2)]
        [String]$SubnetMask
    )

    process {
        try {
            $Network = ConvertToNetwork @psboundparameters
        } catch {
            throw $_
        }

        return ConvertTo-DottedDecimalIP ((ConvertTo-DecimalIP $Network.IPAddress) -bor ((-bnot (ConvertTo-DecimalIP $Network.SubnetMask)) -band [UInt32]::MaxValue))
    }
}