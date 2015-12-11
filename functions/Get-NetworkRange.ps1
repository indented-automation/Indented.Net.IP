function Get-NetworkRange {
  # .SYNOPSIS
  #   Get a list of IP addresses within the specified network.
  # .DESCRIPTION
  #   Get-NetworkRange finds the network and broadcast address as decimal values then starts a counter between the two, returning IPAddress for each.
  # .PARAMETER IPAddress
  #   Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
  # .PARAMETER SubnetMask
  #   A subnet mask as an IP address.
  # .INPUTS
  #   System.Net.IPAddress
  #   System.String
  # .OUTPUTS
  #   System.Net.IPAddress
  # .EXAMPLE
  #   Get-NetworkRange 192.168.0.0 255.255.255.0
  #
  #   Returns all IP addresses in the range 192.168.0.0/24.
  # .EXAMPLE
  #   Get-NetworkRange 10.0.8.0/22
  #
  #   Returns all IP addresses in the range 192.168.0.0 255.255.252.0.
  # .NOTES
  #   Author: Chris Dent
  #
  #   Change log:
  #     13/10/2011 - Chris Dent - Created.

  [CmdLetBinding(DefaultParameterSetName = 'CIDRNotation')]
  param(
    [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true, ParameterSetName = 'CIDRNotation')]
    [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'IPAndMask')]
    [String]$IPAddress,

    [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'IPAndMask')]
    [String]$SubnetMask
  )

  process {
    $Params = ConvertToNetworkObject "$IPAddress $SubnetMask"
    if ($Params.State -ne "No error") {
      Write-Error $Params.State -Category InvalidArgument
      return
    } elseif (-not $Params.SubnetMask) {
      $Params.SubnetMask = ConvertTo-Mask $Params.MaskLength
    }
  
    $DecimalIP = ConvertTo-DecimalIP $Params.IPAddress
    $DecimalMask = ConvertTo-DecimalIP $Params.SubnetMask
  
    $DecimalNetwork = $DecimalIP -band $DecimalMask
    $DecimalBroadcast = $DecimalIP -bor ((-bnot $DecimalMask) -band [UInt32]::MaxValue)

    for ($i = $($DecimalNetwork + 1); $i -lt $DecimalBroadcast; $i++) {
      ConvertTo-DottedDecimalIP $i
    }
  }
}