# Define the base paths
# run dotnet add package Microsoft.CodeAnalysis.LanguageServer.win-x64 --prerelease
# it will error but the package will be downloaded to ~/.nuget/packages/microsoft.codeanalysis.languageserver.win-x64

$nugetPath = "$env:USERPROFILE\.nuget\packages\microsoft.codeanalysis.languageserver.win-x64"
$nvimRoslynPath = "$env:USERPROFILE\AppData\Local\nvim-data\roslyn"

# Delete the contents of the NVIM_ROSLYN_PATH directory
Remove-Item -Recurse -Force "$nvimRoslynPath\*"

# Find the latest version by sorting and picking the last one
$latestVersion = Get-ChildItem -Directory $nugetPath | Sort-Object Name | Select-Object -Last 1

# Check if the latest version directory exists
if (Test-Path "$latestVersion") {
    # Copy the contents of the latest version to the NVIM_ROSLYN_PATH directory
    Copy-Item -Recurse -Force "$latestVersion\content\LanguageServer\win-x64\*" $nvimRoslynPath
    Write-Output "Copied contents of version $latestVersion to $nvimRoslynPath"
} else {
    Write-Output "Latest version directory not found! $latestVersion"
}
