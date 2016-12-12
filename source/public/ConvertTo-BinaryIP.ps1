function ConvertTo-BinaryIP {
    # .SYNOPSIS
    #   Converts a Decimal IP address into a binary format.
    # .DESCRIPTION
    #   ConvertTo-BinaryIP uses System.Convert to switch between decimal and binary format. The output from this function is dotted binary.
    # .PARAMETER IPAddress
    #   An IP Address to convert.
    # .INPUTS
    #   System.Net.IPAddress
    # .OUTPUTS
    #   System.String
    # .EXAMPLE
    #   ConvertTo-BinaryIP 1.2.3.4
    #    
    #   Convert an IP address to a binary format.
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     06/03/2016 - Chris Dent - Cleaned up code, added tests.
    #     25/11/2010 - Chris Dent - Created.

    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [IPAddress]$IPAddress
    )

    process {  
        $Bytes = $IPAddress.GetAddressBytes()
        $Binary = ''
        for ($i = 0; $i -lt $Bytes.Count; $i++) {
            $Binary += [Convert]::ToString($Bytes[$i], 2).PadLeft(8, '0')
            if ($i -lt ($Bytes.Count - 1)) {
                $Binary += '.'
            }
        }
        
        return $Binary
    }
}