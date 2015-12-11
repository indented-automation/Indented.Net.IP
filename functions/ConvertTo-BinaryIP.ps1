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
  #     25/11/2010 - Chris Dent - Created.

  [CmdLetBinding()]
  param(
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
    [IPAddress]$IPAddress
  )

  process {  
    return ($IPAddress.GetAddressBytes() | ForEach-Object { [Convert]::ToString($_, 2).PadLeft(8, '0') }) -join '.'
  }
}