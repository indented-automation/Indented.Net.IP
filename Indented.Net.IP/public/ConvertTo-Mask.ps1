filter ConvertTo-Mask {
    <#
    .SYNOPSIS
        Convert a mask length to a dotted-decimal subnet mask.
    .DESCRIPTION
        ConvertTo-Mask returns a subnet mask in dotted decimal format from an integer value ranging between 0 and 32.
    
        ConvertTo-Mask creates a binary string from the length, converts the string to an unsigned 32-bit integer then calls ConvertTo-DottedDecimalIP to complete the operation.
    .INPUTS
        System.Int32
    .EXAMPLE
        ConvertTo-Mask 24
    
        Returns the dotted-decimal form of the mask, 255.255.255.0.
    .NOTES
        Change log:
            07/09/2017 - Chris Dent - Converted to filter.
            06/03/2016 - Chris Dent - Cleaned up code, added tests.
            25/11/2010 - Chris Dent - Created.
    #>
    
    [OutputType([System.Net.IPAddress])]
    param (
        # The number of bits which must be masked.
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [Alias('Length')]
        [ValidateRange(0, 32)]
        [Byte]$MaskLength
    )
    
    $binary = ("1" * $MaskLength).PadRight(32, "0")
    $decimal = [Convert]::ToUInt32($binary, 2)
    
    ConvertTo-DottedDecimalIP $decimal
}