function ConvertTo-HexIP {
  # .SYNOPSIS
  #   Convert a dotted decimal IP address into a hexadecimal string.
  # .DESCRIPTION
  #   ConvertTo-HexIP takes a dotted decimal IP and returns a single hexadecimal string value.
  # .PARAMETER IPAddress
  #   An IP Address to convert.
  # .INPUTS
  #    System.Net.IPAddress
  # .OUTPUTS
  #    System.String
  # .EXAMPLE
  #   ConvertTo-HexIP 192.168.0.1
  #    
  #   Returns the hexadecimal string c0a80001.
  # .NOTES
  #   Author: Chris Dent
  #
  #   Change log:
  #     13/10/2011 - Chris Dent - Refactored.

  [CmdLetBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [IPAddress]$IPAddress
  )

  process {
    return ($IPAddress.GetAddressBytes() | ForEach-Object { '{0:x2}' -f $_ }) -join ''
  }
}