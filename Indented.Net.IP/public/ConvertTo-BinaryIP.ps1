function ConvertTo-BinaryIP {
    <#
    .SYNOPSIS
        Converts a Decimal IP address into a binary format.
    .DESCRIPTION
        ConvertTo-BinaryIP uses System.Convert to switch between decimal and binary format. The output from this function is dotted binary.
    .INPUTS
        System.Net.IPAddress
    .EXAMPLE
        ConvertTo-BinaryIP 1.2.3.4

        Convert an IP address to a binary format.
    .NOTES
        Change log:
            07/09/2017 - Chris Dent - Converted to filter.
            06/03/2016 - Chris Dent - Cleaned up code, added tests.
            25/11/2010 - Chris Dent - Created.
    #>

    [CmdletBinding()]
    [OutputType([System.String])]
    param (
        # An IP Address to convert.
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [IPAddress]$IPAddress
    )

    process {  
        $bytes = $IPAddress.GetAddressBytes()
        $binary = for ($i = 0; $i -lt $Bytes.Count; $i++) {
            [Convert]::ToString($Bytes[$i], 2).PadLeft(8, '0')
        }
        
        $binary -join '.'
    }
}