#Morrowind's Data folder. Use this variable when using "To".
$saveFolder = $PSScriptRoot

#Destination folder for .zip archive
$zipFolder = [Environment]::GetFolderPath("Desktop")
$zipArchive = Join-Path $zipFolder "Morrowind Saves.zip"

#DO NOT EDIT ANYTHING BELOW THIS LINE!

#.ess files. Use this variable when using "From".
$saveFiles = "*.ess"

function choiceFrom
{
    $fromSwitch=Read-Host "`r`nMST will now attempt to compress your Morrowind from:`r`n`r`n`t$saveFolder`r`n`r`nto a .zip archive at:`r`n`r`n`t$zipArchive`r`n`r`nDo you want to continue? Please make sure the specified file paths are correct before proceeding. [Y]es/[N]o/[B]ack"
    Switch ($fromSwitch)
    {
        Y {Compress-Archive -Path $saveFiles -DestinationPath $zipArchive -Force}
        N {Write-Host "No action taken, shutting down..."; exit}
        B {theChoice}
        default {$fromSwitch=Write-Host "Unknown input."; choiceFrom}
    }
}
function choiceTo
{
    $toSwitch=Read-Host "`r`nMST will now attempt to extract your Morrowind saves from:`r`n`r`n`t$zipArchive`r`n`r`nto your save directory located at:`r`n`r`n`t$saveFolder`r`n`r`nDo you want to continue? Please make sure the specified file paths are correct before proceeding. [Y]es/[N]o/[B]ack"
    Switch ($toSwitch)
    {
        Y {Expand-Archive -Path $zipArchive -DestinationPath $saveFolder -Force}
        N {Write-Host "No action taken, shutting down..."; exit}
        B {theChoice}
        default {$toSwitch=Write-Host "Unknown input."; choiceTo}
    }
}
function theChoice
{
    $whatdo=Read-Host "`r`nAre you migrating your saves FROM or TO this machine? [F]rom, [T]o, e[X]it"
    Switch ($whatdo)
    {
        F {choiceFrom}
        T {choiceTo}
        X {"Quitting..."; exit}
        default {Write-Host "Unknown input."; theChoice}
    }
}

Write-Host "Morrowind Save Tool`r`nSlothSec`r`nv0.0.4"
theChoice
Write-Host "Process complete. Now quitting..."