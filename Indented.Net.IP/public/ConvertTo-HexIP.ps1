function ConvertTo-HexIP {
    <#
    .SYNOPSIS
        Convert a dotted decimal IP address into a hexadecimal string.
    .DESCRIPTION
        ConvertTo-HexIP takes a dotted decimal IP and returns a single hexadecimal string value.
    .PARAMETER IPAddress
        An IP Address to convert.
    .INPUTS
        System.Net.IPAddress
    .EXAMPLE
        ConvertTo-HexIP 192.168.0.1

        Returns the hexadecimal string c0a80001.
    .NOTES
        Change log:
            07/09/2017 - Chris Dent - Converted to filter.
            06/03/2016 - Chris Dent - Cleaned up code, added tests.
            13/10/2011 - Chris Dent - Refactored.
    #>

    [CmdletBinding()]
    [OutputType([System.String])]
    param (
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [IPAddress]$IPAddress
    )

    $bytes = $IPAddress.GetAddressBytes()
    $hex = ''
    for ($i = 0; $i -lt $bytes.Count; $i++) {
        $hex += '{0:x2}' -f $bytes[$i]
    }
    
    $hex
}