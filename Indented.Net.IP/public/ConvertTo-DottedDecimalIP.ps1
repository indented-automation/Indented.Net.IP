filter ConvertTo-DottedDecimalIP {
    <#
    .SYNOPSIS
        Converts either an unsigned 32-bit integer or a dotted binary string to an IP Address.
    .DESCRIPTION
         ConvertTo-DottedDecimalIP uses a regular expression match on the input string to convert to an IP address.
    .INPUTS
        System.String
    .EXAMPLE
        ConvertTo-DottedDecimalIP 11000000.10101000.00000000.00000001

        Convert the binary form back to dotted decimal, resulting in 192.168.0.1.
    .EXAMPLE
        ConvertTo-DottedDecimalIP 3232235521

        Convert the decimal form back to dotted decimal, resulting in 192.168.0.1.
    .NOTES
        Change log:
            07/09/2017 - Chris Dent - Converted to filter.
            06/03/2016 - Chris Dent - Cleaned up code, added tests.
            25/11/2010 - Chris Dent - Created.
    #>

    [CmdletBinding()]
    [OutputType([System.Net.IPAddress])]
    param (
        # A string representation of an IP address from either UInt32 or dotted binary.
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [String]$IPAddress
    )
    
    switch -regex ($IPAddress) {
        "([01]{8}\.){3}[01]{8}" {
            return [IPAddress]([String]::Join('.', $( $IPAddress -split '\.' | ForEach-Object { [Convert]::ToUInt32($_, 2) } )))
        }
        "\d" {
            $Decimal = [UInt32]$IPAddress
            $DottedDecimalIP = ''
            for ($i = 3; $i -ge 0; $i--) {
                $Remainder = $Decimal % [Math]::Pow(256, $i)

                $DottedDecimalIP += ($Decimal - $Remainder) / [Math]::Pow(256, $i)
                if ($i -gt 0) { 
                    $DottedDecimalIP += '.'
                }

                $Decimal = $Remainder
            }
            
            $DottedIP = 3..0 | ForEach-Object {
                $Remainder = $IPAddress % [Math]::Pow(256, $_)
                ($IPAddress - $Remainder) / [Math]::Pow(256, $_)
                $IPAddress = $Remainder
            }
        
            return [IPAddress]($DottedIP -join '.')
        }
        default {
            $ErrorRecord = New-Object System.Management.Automation.ErrorRecord(
                (New-Object ArgumentException 'Cannot convert this format.'),
                'UnrecognisedFormat',
                [System.Management.Automation.ErrorCategory]::InvalidArgument,
                $IPAddress
            )
            Write-Error -ErrorRecord $ErrorRecord
        }
    }
}