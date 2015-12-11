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
  #     25/11/2010 - Chris Dent - Created.
  
  [CmdLetBinding()]
  param(
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
    [IPAddress]$IPAddress
  )

  process {
    $i = 3; $DecimalIP = 0;
    $IPAddress.GetAddressBytes() | ForEach-Object { $DecimalIP += [UInt32]$_ -shl (8 * $i); $i-- }

    return [UInt32]$DecimalIP
  }
}