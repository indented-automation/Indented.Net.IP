@{
    Severity            = @(
        'Error'
        'Warning'
        'Information'
    )
    ExcludeRules        = @(
        'PSDSC*'
        'PSShouldProcess'
        'PSReviewUnusedParameter'
        'PSUseDeclaredVarsMoreThanAssignments'
        'PSUseShouldProcessForStateChangingFunctions'
    )
    IncludeDefaultRules = $true
    Rules               = @{
        PSAvoidUsingDoubleQuotesForConstantString = @{
            Enable = $true
        }

        PSPlaceOpenBrace                          = @{
            Enable             = $true
            OnSameLine         = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
        }

        PSPlaceCloseBrace                         = @{
            Enable             = $true
            NewLineAfter       = $false
            IgnoreOneLineBlock = $true
            NoEmptyLineBefore  = $false
        }

        PSUseConsistentIndentation                = @{
            Enable              = $true
            Kind                = 'space'
            PipelineIndentation = 'IncreaseIndentationForFirstPipeline'
            IndentationSize     = 4
        }

        PSUseConsistentWhitespace                 = @{
            Enable                          = $true
            CheckInnerBrace                 = $true
            CheckOpenBrace                  = $false
            CheckOpenParen                  = $false
            CheckOperator                   = $false
            CheckPipe                       = $true
            CheckPipeForRedundantWhitespace = $false
            CheckSeparator                  = $true
            CheckParameter                  = $false
        }

        PSAlignAssignmentStatement                = @{
            Enable         = $true
            CheckHashtable = $true
        }
    }
}
