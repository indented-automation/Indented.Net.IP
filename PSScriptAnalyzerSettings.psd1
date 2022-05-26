@{
    Severity     = @(
        'Error'
        'Warning'
    )
    IncludeRules = @(
        'PSAlignAssignmentStatement'
        'PSAvoidUsingCmdletAliases'
        'PSAvoidUsingWMICmdlet'
        'PSAvoidUsingEmptyCatchBlock'
        'PSUseCmdletCorrectly'
        'PSAvoidUsingPositionalParameters'
        'PSAvoidGlobalVars'
        'PSAvoidUsingInvokeExpression'
        'PSProvideCommentHelp'
        'PSAvoidUsingPlainTextForPassword'
        'PSAvoidUsingComputerNameHardcoded'
        'PSAvoidUsingConvertToSecureStringWithPlainText'
        'PSUsePSCredentialType'
        'PSAvoidUsingUserNameAndPasswordParams'
        'PSPlaceOpenBrace'
        'PSPlaceCloseBrace'
        'PSUseConsistentWhitespace'
        'PSUseConsistentIndentation'
        'PSAlignAssignmentStatement'
        'PSUseCorrectCasing'
    )
    ExcludeRules = @(
        'PSDSC*'
        'PSUseDeclaredVarsMoreThanAssignments'
        'PSUseShouldProcessForStateChangingFunctions'
    )
    Rules        = @{
        PSPlaceOpenBrace           = @{
            Enable             = $true
            OnSameLine         = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
        }

        PSPlaceCloseBrace          = @{
            Enable             = $true
            NewLineAfter       = $false
            IgnoreOneLineBlock = $true
            NoEmptyLineBefore  = $false
        }

        PSUseConsistentIndentation = @{
            Enable              = $true
            Kind                = 'space'
            PipelineIndentation = 'IncreaseIndentationForFirstPipeline'
            IndentationSize     = 4
        }

        PSUseConsistentWhitespace  = @{
            Enable                          = $true
            CheckInnerBrace                 = $true
            CheckOpenBrace                  = $true
            CheckOpenParen                  = $true
            CheckOperator                   = $false
            CheckPipe                       = $true
            CheckPipeForRedundantWhitespace = $false
            CheckSeparator                  = $true
            CheckParameter                  = $false
        }

        PSAlignAssignmentStatement = @{
            Enable         = $true
            CheckHashtable = $true
        }

        PSUseCorrectCasing         = @{
            Enable = $true
        }
    }
}
