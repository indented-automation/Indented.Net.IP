function ConvertTo-DecimalIP {
    # .SYNOPSIS
    #   Converts a Decimal IP address into a 32-bit unsigned integer.
    # .DESCRIPTION
    #   ConvertTo-DecimalIP takes a decimal IP, uses a shift operation on each octet and returns a single UInt32 value.
    # .PARAMETER IPAddress
    #   An IP Address to convert.
    # .INPUTS
    #   System.Net.IPAddress
    # .OUTPUTS
    #   System.UInt32
    # .EXAMPLE
    #   ConvertTo-DecimalIP 1.2.3.4
    #   
    #   Converts an IP address to an unsigned 32-bit integer value.
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     06/03/2016 - Chris Dent - Cleaned up code, added tests.
    #     25/11/2010 - Chris Dent - Created.
    
    [OutputType([System.UInt32])]
    param(
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [IPAddress]$IPAddress
    )

    process {
        $Bytes = $IPAddress.GetAddressBytes()
        $Decimal = 0;
        for ($i = 0; $i -le 3; $i++) {
            $Decimal += [UInt32]$Bytes[$i] -shl (8 * (3 - $i))
        }

        return [UInt32]$Decimal
    }
}