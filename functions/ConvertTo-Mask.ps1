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
  #     25/11/2010 - Chris Dent - Created.
  
  [CmdLetBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [Alias("Length")]
    [ValidateRange(0, 32)]
    [Byte]$MaskLength
  )
  
  process {
    return ConvertTo-DottedDecimalIP ([Convert]::ToUInt32($(("1" * $MaskLength).PadRight(32, "0")), 2))
  }
}