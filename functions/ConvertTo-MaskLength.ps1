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
  #     25/11/2010 - Chris Dent - Created.

  [CmdLetBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [Alias("Mask")]
    [IPAddress]$SubnetMask
  )

  process {
    $Params = ConvertToNetworkObject 0 $SubnetMask
    if ($Params.State -ne "No error") {
      Write-Error $Params.State -Category InvalidArgument
      return
    }
    
    $Bits = (($SubnetMask.GetAddressBytes() | ForEach-Object { [Convert]::ToString($_, 2) }) -join '') -replace '0'

    return $Bits.Length
  }
}