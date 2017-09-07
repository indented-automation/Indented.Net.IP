filter ConvertFrom-HexIP {
    <#
    .SYNOPSIS
        Converts a hexadecimal IP address into a dotted decimal string.
    .DESCRIPTION
        ConvertFrom-HexIP takes a hexadecimal string and returns a dotted decimal IP address. An intermediate call is made to ConvertTo-DottedDecimalIP.
    .INPUTS
        System.String
    .EXAMPLE
        ConvertFrom-HexIP c0a80001

        Returns the IP address 192.168.0.1.
    .NOTES
        Change log:
            07/09/2017 - Chris Dent - Converted to filter.
            06/03/2016 - Chris Dent - Cleaned up code, added tests.
            13/10/2011 - Chris Dent - Created.
    #>

    [CmdletBinding()]
    [OutputType([System.Net.IPAddress])]
    param (
        # An IP Address to convert.
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [ValidatePattern('^(0x)?[0-9a-f]{8}$')]
        [String]$IPAddress
    )

    ConvertTo-DottedDecimalIP ([Convert]::ToUInt32($IPAddress, 16))
}