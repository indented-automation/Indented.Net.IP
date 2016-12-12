function ConvertFrom-HexIP {
    # .SYNOPSIS
    #   Converts a hexadecimal IP address into a dotted decimal string.
    # .DESCRIPTION
    #   ConvertFrom-HexIP takes a hexadecimal string and returns a dotted decimal IP address. An intermediate call is made to ConvertTo-DottedDecimalIP.
    # .PARAMETER IPAddress
    #   An IP Address to convert.
    # .INPUTS
    #   System.String
    # .OUTPUTS
    #   System.Net.IPAddress
    # .EXAMPLE
    #   ConvertFrom-HexIP c0a80001
    #
    #   Returns the IP address 192.168.0.1.
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     06/03/2016 - Chris Dent - Cleaned up code, added tests.
    #     13/10/2011 - Chris Dent - Created.

    [OutputType([System.Net.IPAddress])]
    param(
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [ValidatePattern('^(0x)?[0-9a-f]{8}$')]
        [String]$IPAddress
    )

    process {
        return ConvertTo-DottedDecimalIP ([Convert]::ToUInt32($IPAddress, 16))
    }
}