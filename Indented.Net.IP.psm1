#
# Module loader for Indented.Net.IP
#
# Author: Chris Dent
#
# Change log:
#   02/04/2015 - Chris Dent - Refactored.
#   05/07/2012 - Chris Dent - Created.

# Internal functions
[Array]$Internal = 'ConvertToNetworkObject'

if ($Internal.Count -ge 1) {
  $Internal | ForEach-Object {
    Import-Module "$psscriptroot\functions-internal\$_.ps1"
  }
}

# Public functions
[Array]$Public = 'ConvertFrom-HexIP',
                 'ConvertTo-BinaryIP',
                 'ConvertTo-DecimalIP',
                 'ConvertTo-DottedDecimalIP',
                 'ConvertTo-HexIP',
                 'ConvertTo-Mask',
                 'ConvertTo-MaskLength',
                 'ConvertTo-Subnet',
                 'Get-BroadcastAddress',
                 'Get-NetworkAddress',
                 'Get-NetworkRange',
                 'Get-NetworkSummary',
                 'Get-Subnets',
                 'Test-SubnetMember'

if ($Public.Count -ge 1) {
  $Public | ForEach-Object {
    Import-Module "$psscriptroot\functions\$_.ps1"
  }
}