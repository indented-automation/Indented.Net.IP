function ConvertTo-Mask {
    # .SYNOPSIS
    #   Convert a mask length to a dotted-decimal subnet mask.
    # .DESCRIPTION
    #   ConvertTo-Mask returns a subnet mask in dotted decimal format from an integer value ranging between 0 and 32.
    #
    #   ConvertTo-Mask creates a binary string from the length, converts the string to an unsigned 32-bit integer then calls ConvertTo-DottedDecimalIP to complete the operation.
    # .PARAMETER MaskLength
    #   The number of bits which must be masked.
    # .INPUTS
    #   System.Int32
    # .OUTPUTS
    #   System.Net.IPAddress
    # .EXAMPLE
    #   ConvertTo-Mask 24
    #
    #   Returns the dotted-decimal form of the mask, 255.255.255.0.
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     06/03/2016 - Chris Dent - Cleaned up code, added tests.
    #     25/11/2010 - Chris Dent - Created.
    
    [OutputType([System.Net.IPAddress])]
    param(
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [Alias('Length')]
        [ValidateRange(0, 32)]
        [Byte]$MaskLength
    )
    
    process {
        $Binary = ("1" * $MaskLength).PadRight(32, "0")
        $Decimal = [Convert]::ToUInt32($Binary, 2)
        
        return ConvertTo-DottedDecimalIP $Decimal
    }
}