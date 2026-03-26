param(
    [string]$InputFile = ".\sourcecode\msfsSafeMode.ps1",
    [string]$OutputFile = ".\distribution\msfsSafeMode.exe",
    [string]$IconFile = ".\UI images\icon.ico",
    [string]$Title = "msfs-safeModeSwitch",
    [string]$Company = "teezythakidd",
    [string]$Product = "msfs-safeModeSwitch",
    [string]$Version = "2.7.0.0",
    [string]$Description = "Launch Microsoft Flight Simulator 2020 or 2024 in Safe Mode or Normal Mode."
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$inputPath = Join-Path $repoRoot $InputFile
$outputPath = Join-Path $repoRoot $OutputFile
$iconPath = Join-Path $repoRoot $IconFile
$outputDirectory = Split-Path -Parent $outputPath

if (-not (Test-Path $inputPath)) {
    throw "Input script not found: $inputPath"
}

if (-not (Test-Path $outputDirectory)) {
    New-Item -Path $outputDirectory -ItemType Directory -Force | Out-Null
}

# Only relax execution policy for this PowerShell process so ps2exe can import.
Set-ExecutionPolicy -Scope Process Bypass -Force
Import-Module ps2exe

$buildArguments = @{
    inputFile   = $inputPath
    outputFile  = $outputPath
    noConsole   = $true
    title       = $Title
    company     = $Company
    product     = $Product
    version     = $Version
    description = $Description
}

if (Test-Path $iconPath) {
    $buildArguments.iconFile = $iconPath
} else {
    Write-Host "Icon file not found at $iconPath. Building without a custom icon." -ForegroundColor Yellow
}

Invoke-PS2EXE @buildArguments

Write-Host "Build complete: $outputPath" -ForegroundColor Green
