function ConvertTo-DottedDecimalIP {
  # .SYNOPSIS
  #   Converts either an unsigned 32-bit integer or a dotted binary string to an IP Address.
  # .DESCRIPTION
  #   ConvertTo-DottedDecimalIP uses a regular expression match on the input string to convert to an IP address.
  # .PARAMETER IPAddress
  #   A string representation of an IP address from either UInt32 or dotted binary.
  # .INPUTS
  #   System.String
  # .OUTPUTS
  #   System.Net.IPAddress
  # .EXAMPLE
  #   ConvertTo-DottedDecimalIP 11000000.10101000.00000000.00000001
  #    
  #   Convert the binary form back to dotted decimal, resulting in 192.168.0.1.
  # .EXAMPLE
  #   ConvertTo-DottedDecimalIP 3232235521
  #    
  #   Convert the decimal form back to dotted decimal, resulting in 192.168.0.1.
  # .NOTES
  #   Author: Chris Dent
  #
  #   Change log:
  #     25/11/2010 - Chris Dent - Created.

  [CmdLetBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [String]$IPAddress
  )
  
  process {
    switch -regex ($IPAddress) {
      "([01]{8}\.){3}[01]{8}" {
        return [IPAddress]([String]::Join('.', $( $IPAddress -split '\.' | ForEach-Object { [Convert]::ToUInt32($_, 2) } )))
      }
      "\d" {
        $IPAddress = [UInt32]$IPAddress
        $DottedIP = 3..0 | ForEach-Object {
          $Remainder = $IPAddress % [Math]::Pow(256, $_)
          ($IPAddress - $Remainder) / [Math]::Pow(256, $_)
          $IPAddress = $Remainder
         }
       
        return [IPAddress]($DottedIP -join '.')
      }
      default {
        Write-Error "ConvertTo-DottedDecimalIP: Cannot convert this format"
      }
    }
  }
}