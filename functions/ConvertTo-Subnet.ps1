function ConvertTo-Subnet {
  # .SYNOPSIS
  #   Convert a start and end IP address to the closest matching subnet.
  # .DESCRIPTION
  #   ConvertTo-Subnet attempts to convert a starting and ending IP address from a range to the closest subnet.
  # .PARAMETER Start
  #   The first IP address from a range.
  # .PARAMETER End
  #   The last IP address from a range.
  # .INPUTS
  #   System.Net.IPAddress
  # .OUTPUTS
  #   Indented.NetworkTools.NetworkSummary
  # .EXAMPLE
  #   ConvertTo-Subnet 0.0.0.0 255.255.255.255
  # .EXAMPLE
  #   ConvertTo-Subnet 192.168.0.1 192.168.0.129
  # .EXAMPLE
  #   ConvertTo-Subnet 10.0.0.1 11.0.0.1
  # .EXAMPLE
  #   ConvertTo-Subnet 10.0.0.126 10.0.0.129
  # .EXAMPLE
  #   ConvertTo-Subnet 10.0.0.128 10.0.0.128
  # .EXAMPLE
  #   ConvertTo-Subnet 10.0.0.128 10.0.0.130
  # .NOTES
  #   Author: Chris Dent
  #
  #   Change log:
  #     14/05/2014 - Chris Dent - Created.
  
  [CmdLetBinding()]
  param(
    [IPAddress]$Start,

    [IPAddress]$End
  )

  if ($Start -eq $End) {
    return (Get-NetworkSummary "$Start\32")
  }

  $DecimalStart = ConvertTo-DecimalIP $Start
  $DecimalEnd = ConvertTo-DecimalIP $End

  $i = 32
  do {
    $i--
  } until (($DecimalStart -band ([UInt32]1 -shl $i)) -ne ($DecimalEnd -band ([UInt32]1 -shl $i)))
  return (Get-NetworkSummary "$Start\$(32 - $i - 1)")
}