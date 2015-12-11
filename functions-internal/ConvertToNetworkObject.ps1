function ConvertToNetworkObject {
  # .SYNOPSIS
  #   Converts IP address formats to a set a known styles.
  # .DESCRIPTION
  #   Internal use only.
  #
  #   ConvertToNetworkObject ensures consistent values are recorded from parameters which must handle differing addressing formats. This CmdLet allows all other the other functions in this module to offload parameter handling.
  #
  #   Note: the functionality of this CmdLet is deliberately limited. Part of the reason this module exists is to demostrate (in small pieces) IP maths, if all of it is loaded into this hidden function it defeats the point.
  # .PARAMETER IPAddress
  #   Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
  # .PARAMETER SubnetMask
  #   A subnet mask as an IP address.
  # .INPUTS
  #   System.String
  # .OUTPUTS
  #   Indented.Net.NetworkObject
  # .NOTES
  #   Author: Chris Dent
  #
  #   Change log:
  #     14/01/2014 - Chris Dent - Created.
  
  [CmdLetBinding(DefaultParameterSetName = 'CIDRNotation')]
  param(
    [Parameter(Mandatory = $true, Position = 1, ValueFromPipeLine = $true, ParameterSetName = 'CIDRNotation')]
    [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'IPAndMask')]
    [String]$IPAddress,
    
    [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'IPAndMask')]
    [String]$SubnetMask
  )
 
  $NetworkObject = New-Object PsObject -Property ([Ordered]@{
    IPAddress  = $null;
    SubnetMask = $null;
    MaskLength = [Byte]0;
    State      = "No error";
  })
  $NetworkObject.PsObject.TypeNames.Add("Indented.Net.NetworkObject")
  
  # A bit of cleaning
  $IPAddress = $IPAddress.Trim()
  $SubnetMask = $SubnetMask.Trim()
  
  # Handling for IP and Mask as a single string
  if ($IPAddress -match '^(\S+)\s(\S+)$') {
    # Send it back into this function sort out the values now.
    return ConvertToNetworkObject $matches[1] $matches[2]
  }
  
  # IPAddress handling
  
  $IPAddressTest = New-Object IPAddress 0
  if ([IPAddress]::TryParse($IPAddress, [Ref]$IPAddressTest)) {
    if ($IPAddressTest.AddressFamily -eq [Net.Sockets.AddressFamily]::InterNetwork) {
      $NetworkObject.IPAddress = $IPAddressTest
    } else {
      $NetworkObject.State = "Unexpected IPv6 address for IPAddress."
    }
  } elseif ($myinvocation.BoundParameters.ContainsKey("SubnetMask")) {
    $NetworkObject.State = "Invalid IP address format."
  } else {
    # Begin string parsing
    if ($IPAddress -match '^(?<IPAddress>(?:[0-9]{1,2}|[0-1][0-9]{2}|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]{1,2}|[0-1][0-9]{2}|2[0-4][0-9]|25[0-5])){0,3})[\\/](?<SubnetMask>\d+)$') {
      # Fix up the IP address
      $IPAddressBuilder = [Array]($matches.IPAddress -split '\.' | ForEach-Object { [Byte]$_ })
      while ($IPAddressBuilder.Count -lt 4) {
        $IPAddressBuilder += 0
      }

      if ([IPAddress]::TryParse(($IPAddressBuilder -join '.'), [Ref]$IPAddressTest)) {
        $NetworkObject.IPAddress = $IPAddressTest
      } else {
        $NetworkObject.State = "Matched regular expression, but still failed to convert. Unexpected error."
      }
     
      # Hold this for a moment or two.
      [Byte]$MaskLength = $matches.SubnetMask
    } else {
      $NetworkObject.State = "Invalid CIDR notation format."
    }
  }

  # SubnetMask handling  
  
  # Validation cannot be (easily) done using a regular expression. Hard-coding this as a string comparison should be nice and fast.
  # These can be dynamically generated as follows:
  #
  #   1..32 | ForEach-Object { ConvertTo-Mask $_ }
  #
  # However, the values never change and an array of strings takes little memory and requires no computation.
  $ValidSubnetMaskValues = "0.0.0.0", "128.0.0.0", "192.0.0.0", "224.0.0.0", "240.0.0.0", "248.0.0.0", "252.0.0.0", "254.0.0.0", "255.0.0.0",
    "255.128.0.0", "255.192.0.0", "255.224.0.0", "255.240.0.0", "255.248.0.0", "255.252.0.0", "255.254.0.0", "255.255.0.0",
    "255.255.128.0", "255.255.192.0", "255.255.224.0", "255.255.240.0", "255.255.248.0", "255.255.252.0", "255.255.254.0", "255.255.255.0",
    "255.255.255.128", "255.255.255.192", "255.255.255.224", "255.255.255.240", "255.255.255.248", "255.255.255.252", "255.255.255.254", "255.255.255.255"
  
  if ($myinvocation.BoundParameters.ContainsKey("SubnetMask") -and $NetworkObject.State -eq "No Error") {
    if ([IPAddress]::TryParse($SubnetMask, [Ref]$IPAddressTest)) {
      if ($IPAddressTest.AddressFamily -eq [Net.Sockets.AddressFamily]::InterNetwork) {
        if ($IPAddressTest.ToString() -notin $ValidSubnetMaskValues) {
          $NetworkObject.State = "Invalid subnet mask value."
        } else {
          $NetworkObject.SubnetMask = $IPAddressTest
        }
      } else {
        $NetworkObject.State = "Unexpected IPv6 address for SubnetMask."
      }
    } else {
      $NetworkObject.State = "Invalid subnet mask format."
    }
  } elseif ($NetworkObject.State -eq "No error") {
    if ($MaskLength -eq $null) {
      # Default the length to 32 bits.
      $NetworkObject.MaskLength = 32
    } elseif ($MaskLength -ge 0 -and $MaskLength -le 32) {
      $NetworkObject.MaskLength = $MaskLength
    } else {
      $NetworkObject.State = "Mask length out of range (expecting 0 to 32)."
    }
  }
  
  return $NetworkObject
}