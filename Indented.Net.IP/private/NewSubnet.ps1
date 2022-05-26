function NewSubnet {
    <#
    .SYNOPSIS
        Creates an IP subnet object.

    .DESCRIPTION
        Creates an IP subnet object.

    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $NetworkAddress,

        $BroadcastAddress,

        $SubnetMask,

        $MaskLength
    )

    if ($NetworkAddress -isnot [IPAddress]) {
        $NetworkAddress = ConvertTo-DottedDecimalIP $NetworkAddress
    }
    if ($BroadcastAddress -and $BroadcastAddress -isnot [IPAddress]) {
        $BroadcastAddress = ConvertTo-DottedDecimalIP $BroadcastAddress
    }
    if ($NetworkAddress -eq $BroadcastAddress) {
        $SubnetMask = '255.255.255.255'
        $MaskLength = 32
        $HostAddresses = 0
    } else {
        # One of these will be provided
        if (-not $SubnetMask) {
            $SubnetMask = ConvertTo-Mask $MaskLength
        }
        if (-not $MaskLength) {
            $MaskLength = ConvertTo-MaskLength $SubnetMask
        }
        $HostAddresses = [Math]::Pow(2, (32 - $MaskLength)) - 2
        if ($HostAddresses -lt 0) {
            $HostAddresses = 0
        }
    }
    if (-not $BroadcastAddress) {
        $BroadcastAddress = Get-BroadcastAddress -IPAddress $NetworkAddress -SubnetMask $SubnetMask
    }

    [PSCustomObject]@{
        Cidr             = '{0}/{1}' -f $NetworkAddress, $MaskLength
        NetworkAddress   = $NetworkAddress
        BroadcastAddress = $BroadcastAddress
        SubnetMask       = $SubnetMask
        MaskLength       = $MaskLength
        HostAddresses    = $HostAddresses
        PSTypeName       = 'Indented.Net.IP.Subnet'
    } | Add-Member ToString -MemberType ScriptMethod -Force -PassThru -Value {
        return $this.Cidr
    }
}
