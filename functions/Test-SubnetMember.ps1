function Test-SubnetMember {
  # .SYNOPSIS
  #   Tests an IP address to determine if it falls within IP address range.
  # .DESCRIPTION
  #   Test-SubnetMember attempts to determine whether or not an address or range falls within another range. The network and broadcast address are calculated the converted to decimal then compared to the decimal form of the submitted address.
  # .PARAMETER ObjectIPAddress
  #   A representation of the object, the network to test against. Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
  # .PARAMETER ObjectSubnetMask
  #   A subnet mask as an IP address.
  # .PARAMETER SubjectIPAddress
  #   A representation of the subject, the network to be tested. Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
  # .PARAMETER SubjectSubnetMask
  #   A subnet mask as an IP address.
  # .INPUTS
  #    System.String
  # .OUTPUTS
  #    System.Boolean
  # .EXAMPLE
  #   Test-SubnetMember -SubjectIPAddress 10.0.0.0/24 -ObjectIPAddress 10.0.0.0/16
  #    
  #   Returns true as the subject network can be contained within the object network.
  # .EXAMPLE
  #   Test-SubnetMember -SubjectIPAddress 192.168.0.0/16 -ObjectIPAddress 192.168.0.0/24
  #    
  #   Returns false as the subject network is larger the object network.
  # .EXAMPLE
  #   Test-SubnetMember -SubjectIPAddress 10.2.3.4/32 -ObjectIPAddress 10.0.0.0/8
  #    
  #   Returns true as the subject IP address is within the object network.
  # .EXAMPLE
  #   Test-SubnetMember -SubjectIPAddress 255.255.255.255 -ObjectIPAddress 0/0
  #
  #   Returns true as the subject IP address is the last in the object network range.
  # .NOTES
  #   Author: Chris Dent
  #
  #   Change log:
  #     12/08/2013 - Chris Dent - Created.

  [CmdLetBinding(DefaultParameterSetName = 'CIDRNotation')]
  param(
    [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'CIDRNotation')]
    [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'IPAndMask')]
    [String]$SubjectIPAddress,

    [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'IPAndMask')]
    [String]$SubjectSubnetMask,
    
    [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'CIDRNotation')]
    [Parameter(Mandatory = $true, Position = 3, ParameterSetName = 'IPAndMask')]
    [String]$ObjectIPAddress,

    [Parameter(Mandatory = $true, Position = 4, ParameterSetName = 'IPAndMask')]
    [String]$ObjectSubnetMask
  )

  $SubjectParams = ConvertToNetworkObject "$SubjectIPAddress $SubjectSubnetMask"
  if ($SubjectParams.State -ne "No error") {
    Write-Error "Subject: $($SubjectParams.State)" -Category InvalidArgument
    return
  } elseif (-not $SubjectParams.SubnetMask) {
    $SubjectParams.SubnetMask = ConvertTo-Mask $SubjectParams.MaskLength
  }

  $ObjectParams = ConvertToNetworkObject "$ObjectIPAddress $ObjectSubnetMask"
  if ($ObjectParams.State -ne "No error") {
    Write-Error "Object: $($ObjectParams.State)" -Category InvalidArgument
    return
  } elseif (-not $ObjectParams.SubnetMask) {
    $ObjectParams.SubnetMask = ConvertTo-Mask $ObjectParams.MaskLength
  }
  
  # A simple check, if the mask is shorter (larger network) then it won't be a subnet of the object anyway.
  if ($SubjectParams.MaskLength -lt $ObjectParams.MaskLength) {
    return $false
  }
  
  $SubjectDecimalIP = ConvertTo-DecimalIP $SubjectParams.IPAddress
  $ObjectDecimalNetwork = ConvertTo-DecimalIP (Get-NetworkAddress "$($ObjectParams.IPAddress) $($ObjectParams.SubnetMask)")
  $ObjectDecimalBroadcast = ConvertTo-DecimalIP (Get-BroadcastAddress "$($ObjectParams.IPAddress) $($ObjectParams.SubnetMask)")
  
  # If the mask is longer (smaller network), then the decimal form of the address must be between the 
  # network and broadcast address of the object (the network we test against).
  if ($SubjectDecimalIP -ge $ObjectDecimalNetwork -and $SubjectDecimalIP -le $ObjectDecimalBroadcast) {
    return $true
  } else {
    return $false
  }
}