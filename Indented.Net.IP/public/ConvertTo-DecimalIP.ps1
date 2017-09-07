filter ConvertTo-DecimalIP {
    <#
    .SYNOPSIS
        Converts a Decimal IP address into a 32-bit unsigned integer.
    .DESCRIPTION
        ConvertTo-DecimalIP takes a decimal IP, uses a shift operation on each octet and returns a single UInt32 value.
    .INPUTS
        System.Net.IPAddress
    .EXAMPLE
        ConvertTo-DecimalIP 1.2.3.4

        Converts an IP address to an unsigned 32-bit integer value.
    .NOTES
        Change log:
            07/09/2017 - Chris Dent - Converted to filter.
            06/03/2016 - Chris Dent - Cleaned up code, added tests.
            25/11/2010 - Chris Dent - Created.
    #>

    [CmdletBinding()]
    [OutputType([System.UInt32])]
    param (
        # An IP Address to convert.
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [IPAddress]$IPAddress
    )

    $bytes = $IPAddress.GetAddressBytes()
    [UInt32]$decimal = 0;
    for ($i = 0; $i -le 3; $i++) {
        $decimal += [UInt32]$bytes[$i] -shl (8 * (3 - $i))
    }

    [UInt32]$decimal
}