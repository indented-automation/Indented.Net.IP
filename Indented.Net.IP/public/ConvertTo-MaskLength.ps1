filter ConvertTo-MaskLength {
    <#
    .SYNOPSIS
        Convert a dotted-decimal subnet mask to a mask length.
    .DESCRIPTION
        A count of the number of 1's in a binary string.
    .INPUTS
        System.Net.IPAddress
    .EXAMPLE
        ConvertTo-MaskLength 255.255.255.0
        
        Returns 24, the length of the mask in bits.
    .NOTES
        Change log:
            07/09/2017 - Chris Dent - Converted to filter.
            06/03/2016 - Chris Dent - Cleaned up code, added tests.
            25/11/2010 - Chris Dent - Created.
    #>

    [CmdletBinding()]
    [OutputType([System.Int32])]
    param (
        # A subnet mask to convert into length.
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [Alias("Mask")]
        [IPAddress]$SubnetMask
    )

    $bytes = $SubnetMask.GetAddressBytes()
    $octets = for ($i = 0; $i -lt $bytes.Count; $i++) {
        [Convert]::ToString($bytes[$i], 2)
    }
    
    ($octets -join '').Trim('0').Length
}