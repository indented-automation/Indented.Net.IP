function ConvertTo-Subnet {
    # .SYNOPSIS
    #   Convert a start and end IP address to the closest matching subnet.
    # .DESCRIPTION
    #   ConvertTo-Subnet attempts to convert a starting and ending IP address from a range to the closest subnet.
    # .PARAMETER End
    #   The last IP address from a range.
    # .PARAMETER IPAddress
    #    Any IP address in the subnet.
    # .PARAMETER Start
    #   The first IP address from a range.
    # .PARAMETER SubnetMask
    #    A subnet mask.
    # .INPUTS
    #   System.Net.IPAddress
    # .OUTPUTS
    #   Indented.Net.IP.Subnet
    # .EXAMPLE
    #   ConvertTo-Subnet -Start 0.0.0.0 -End 255.255.255.255
    # .EXAMPLE
    #   ConvertTo-Subnet -Start 192.168.0.1 -End 192.168.0.129
    # .EXAMPLE
    #   ConvertTo-Subnet 10.0.0.23/24
    # .EXAMPLE
    #   ConvertTo-Subnet 10.0.0.23 255.255.255.0
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     06/03/2016 - Chris Dent - Cleaned up code, added tests.
    #     14/05/2014 - Chris Dent - Created.
    
    [CmdletBinding(DefaultParameterSetName = 'FromIPAndMask')]
    [OutputType([System.Management.Automation.PSObject])]
    param(
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'FromIPAndMask')]
        [String]$IPAddress,
        
        [Parameter(Position = 2, ParameterSetName = 'FromIPAndMask')]
        [String]$SubnetMask,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'FromStartAndEnd')]
        [IPAddress]$Start,

        [Parameter(Mandatory = $true, ParameterSetName = 'FromStartAndEnd')]
        [IPAddress]$End
    )

    process {
        if ($pscmdlet.ParameterSetName -eq 'FromIPAndMask') {
            try {
                $Network = ConvertToNetwork @psboundparameters
            } catch {
                $pscmdlet.ThrowTerminatingError($_)
            }
        } elseif ($pscmdlet.ParameterSetName -eq 'FromStartAndEnd') {
            if ($Start -eq $End) {
                $MaskLength = 32
            } else {
                $DecimalStart = ConvertTo-DecimalIP $Start
                $DecimalEnd = ConvertTo-DecimalIP $End

                if ($DecimalEnd -lt $DecimalStart) {
                    $Start = $End
                }
                
                # Find the point the binary representation of each IP address diverges
                $i = 32
                do {
                    $i--
                } until (($DecimalStart -band ([UInt32]1 -shl $i)) -ne ($DecimalEnd -band ([UInt32]1 -shl $i)))

                $MaskLength = 32 - $i - 1
            }
            
            try {
                $Network = ConvertToNetwork "$Start/$MaskLength"
            } catch {
                $pscmdlet.ThrowTerminatingError($_)
            }
        }
        
        $HostAddresses = [Math]::Pow(2, (32 - $Network.MaskLength)) - 2
        if ($HostAddresses -lt 0) { $HostAddresses = 0 }
        
        $Subnet = [PSCustomObject]@{
            NetworkAddress   = Get-NetworkAddress $Network.ToString()
            BroadcastAddress = Get-BroadcastAddress $Network.ToString()
            SubnetMask       = $Network.SubnetMask
            MaskLength       = $Network.MaskLength
            HostAddresses    = $HostAddresses
        } | Add-Member -TypeName 'Indented.Net.IP.Subnet' -PassThru
        
        $Subnet | Add-Member ToString -MemberType ScriptMethod -Force -Value {
            return '{0}/{1}' -f $this.NetworkAddress, $this.MaskLength
        }
        
        $Subnet
    }
}

