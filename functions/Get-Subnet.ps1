function Get-Subnet {
    # .SYNOPSIS
    #   Get a list of subnets of a given size within a defined supernet.
    # .DESCRIPTION
    #   Generates a list of subnets for a given network range using either the address class or a user-specified value.
    # .PARAMETER NetworkAddress
    #   Any address in the super-net range. Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
    # .PARAMETER SubnetMask
    #   The subnet mask of the network to split. Mandatory if the subnet mask is not included in the IPAddress parameter.
    # .PARAMETER NewSubnetMask
    #   Split the existing network described by the IPAddress and subnet mask using this mask.
    # .INPUTS
    #   System.String
    # .OUTPUTS
    #   Indented.Net.IP.Subnet
    # .EXAMPLE
    #   Get-Subnet 10.0.0.0 255.255.255.0 -NewSubnetMask 255.255.255.192
    #   
    #   Four /26 networks are returned.
    # .EXAMPLE
    #   Get-Subnet 0/22 -NewSubnetMask 24
    #
    #   64 /24 networks are returned.
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     07/03/2016 - Chris Dent - Cleaned up code, added tests.
    #     12/12/2015 - Chris Dent - Redesigned.
    #     13/10/2011 - Chris Dent - Created.

    [OutputType([System.Management.Automation.PSObject])]
    param(
        [Parameter(Mandatory = $true, Position = 1)]
        [String]$IPAddress,

        [Parameter(Position = 2)]
        [String]$SubnetMask,
        
        [Parameter(Mandatory = $true)]
        [String]$NewSubnetMask
    )

    $null = $psboundparameters.Remove('NewSubnetMask')
    try {
        $Network = ConvertToNetwork @psboundparameters
    } catch {
        throw $_
    }
    
    try {
        $NewNetwork = ConvertToNetwork "0/$NewSubnetMask"
    } catch {
        throw $_
    }
    
    if ($Network.MaskLength -gt $NewNetwork.MaskLength) {
        $ErrorRecord = New-Object System.Management.Automation.ErrorRecord(
            (New-Object ArgumentException 'The subnet mask of the new network is shorter (masks fewer addresses) than the subnet mask of the existing network.'),
            'NewSubnetMaskTooShort',
            [System.Management.Automation.ErrorCategory]::InvalidArgument,
            $NewNetwork.MaskLength
        )            
        throw $ErrorRecord
    }

    $NumberOfNets = [Math]::Pow(2, ($NewNetwork.MaskLength - $Network.MaskLength))
    $NumberOfAddresses = [Math]::Pow(2, (32 - $NewNetwork.MaskLength))

    $DecimalAddress = ConvertTo-DecimalIP (Get-NetworkAddress $Network.ToString())
    for ($i = 0; $i -lt $NumberOfNets; $i++) {
        $NetworkAddress = ConvertTo-DottedDecimalIP $DecimalAddress
        
        ConvertTo-Subnet "$NetworkAddress/$($NewNetwork.MaskLength)" 

        $DecimalAddress += $NumberOfAddresses
    }
}