function ConvertTo-MaskLength {
    # .SYNOPSIS
    #   Convert a dotted-decimal subnet mask to a mask length.
    # .DESCRIPTION
    #   A simple count of the number of 1's in a binary string.
    # .PARAMETER SubnetMask
    #   A subnet mask to convert into length.
    # .INPUTS
    #   System.Net.IPAddress
    # .OUTPUTS
    #   System.Int32
    # .EXAMPLE
    #   ConvertTo-MaskLength 255.255.255.0
    #
    #   Returns 24, the length of the mask in bits.
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     06/03/2016 - Chris Dent - Cleaned up code, added tests.
    #     25/11/2010 - Chris Dent - Created.

    [OutputType([System.Int32])]
    param(
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [Alias("Mask")]
        [IPAddress]$SubnetMask
    )

    process {
        $Bytes = $SubnetMask.GetAddressBytes()
        $MaskBits = ''
        for ($i = 0; $i -lt $Bytes.Count; $i++) {
            $MaskBits += [Convert]::ToString($Bytes[$i], 2)
        }
        
        return $MaskBits.Replace('0', '').Length
    }
}