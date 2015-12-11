function Get-Subnets {
  # .SYNOPSIS
  #   Get a list of subnets of a given size within a defined supernet.
  # .DESCRIPTION
  #   Generates a list of subnets for a given network range using either the address class or a user-specified value.
  # .PARAMETER NetworkAddress
  #   Any address in the super-net range. Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
  # .PARAMETER SubnetMask
  #   The desired mask, determines the size of the resulting subnets. Must be a valid subnet mask.
  # .PARAMETER SupernetLength
  #   By default Get-Subnets uses the address class to determine the size of the supernet. Where the supernet describes the range of addresses being split.
  # .INPUTS
  #   System.String
  #   System.UInt32
  # .OUTPUTS
  #   System.Object[]
  # .EXAMPLE
  #   Get-Subnets 10.0.0.0 255.255.255.192 -SupernetLength 24
  #   
  #   Four /26 networks are returned.
  # .EXAMPLE
  #   Get-Subnets 10.0.0.0 255.255.0.0
  #   
  #   The supernet size is assumed to be 8, the mask length for a class A network. 256 /16 networks are returned.
  # .EXAMPLE
  #   Get-Subnets 0/8 -SupernetLength 0
  # .NOTES
  #   Author: Chris Dent
  #
  #   Change log:
  #     13/10/2011 - Chris Dent - Created.

  [CmdLetBinding(DefaultParameterSetName = 'CIDRNotation')]
  param(
    [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true, ParameterSetName = 'CIDRNotation')]
    [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'IPAndMask')]
    [String]$NetworkAddress,

    [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'IPAndMask')]
    [String]$SubnetMask,
    
    [ValidateRange(0, 32)]
    [UInt32]$SupernetLength
  )

  process {
    $Params = ConvertToNetworkObject "$NetworkAddress $SubnetMask"
    if ($Params.State -ne "No error") {
      Write-Error $Params.State -Category InvalidArgument
      return
    } elseif (-not $Params.SubnetMask) {
      $Params.SubnetMask = ConvertTo-Mask $Params.MaskLength
    } elseif ($Params.MaskLength -eq 0) {
      $Params.MaskLength = ConvertTo-MaskLength $Params.SubnetMask
    }
    
    if (-not $myinvocation.BoundParameters.ContainsKey("SupernetLength")) {
      $SupernetLength = switch -regex (ConvertTo-BinaryIP $Params.IPAddress) {
        "^110"  { 24 }
        "^10"   { 16 }
        "^0"    { 8 }
        default { 24 }
      }
    }
    
    if ($SupernetLength -gt $Params.MaskLength) {
      Write-Error "Subnet is larger than supernet. Aborting"
      return
    }

    $NumberOfNets = [Math]::Pow(2, ($Params.MaskLength - $SupernetLength))
    $NumberOfAddresses = [Math]::Pow(2, (32 - $Params.MaskLength))

    $DecimalAddress = ConvertTo-DecimalIP (Get-NetworkAddress "$($Params.IPAddress)/$SupernetLength")
    for ($i = 0; $i -lt $NumberOfNets; $i++) {
      $NetworkAddress = ConvertTo-DottedDecimalIP $DecimalAddress 

      $Subnet = New-Object PsObject -Property ([Ordered]@{
        NetworkAddress   = $NetworkAddress;
        BroadcastAddress = (Get-BroadcastAddress $NetworkAddress $Params.SubnetMask);
        SubnetMask       = $Params.SubnetMask;
        SubnetLength     = $Params.MaskLength;
        HostAddresses    = $(
          $NumberOfHosts = $NumberOfAddresses - 2
          if ($NumberOfHosts -lt 0) { 0 } else { $NumberOfHosts }
        );
      })
      $Subnet.PsObject.TypeNames.Add("Indented.NetworkTools.Subnet")
      
      $Subnet
      
      $DecimalAddress += $NumberOfAddresses
    }
  }
}