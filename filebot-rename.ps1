# ========================================================================
# FileBot Rename Script - PowerShell (Windows)
# Usage: .\filebot-rename.ps1 -Type <type> -Input <folder> [-Action test|move]
# Types: movies, tv-tvdb, tv-tmdb, sports, courses
# ========================================================================

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("movies", "tv-tvdb", "tv-tmdb", "sports", "courses")]
    [string]$Type,

    [Parameter(Mandatory=$true)]
    [string]$Input,

    [ValidateSet("test", "move")]
    [string]$Action = "test"
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigDir = Join-Path $ScriptDir "config"
$LogsDir = Join-Path $ScriptDir "logs"

# Load paths if available
$PathsEnv = Join-Path $ConfigDir "paths.env"
if (Test-Path $PathsEnv) {
    Get-Content $PathsEnv | ForEach-Object {
        if ($_ -match '^\s*([^=]+)=(.+)$') {
            $name = $matches[1].Trim()
            $value = $matches[2].Trim()
            Set-Variable -Name $name -Value $value -Scope Global
        }
    }
}

# Ensure logs directory exists
New-Item -ItemType Directory -Force -Path $LogsDir | Out-Null

# Set database and format based on type
switch ($Type) {
    "movies" {
        $DB = "TheMovieDB"
        $Format = "@$ConfigDir/filebot/presets/movies.format"
        $Log = "$LogsDir/movies.log"
    }
    "tv-tvdb" {
        $DB = "TheTVDB"
        $Format = "@$ConfigDir/filebot/presets/tv-tvdb.format"
        $Log = "$LogsDir/tv-tvdb.log"
    }
    "tv-tmdb" {
        $DB = "TheMovieDB"
        $Format = "@$ConfigDir/filebot/presets/tv-tmdb.format"
        $Log = "$LogsDir/tv-tmdb.log"
    }
    "sports" {
        $DB = "TheTVDB"
        $Format = "@$ConfigDir/filebot/presets/sports.format"
        $Log = "$LogsDir/sports.log"
    }
    "courses" {
        $DB = "TheTVDB"
        $Format = "@$ConfigDir/filebot/presets/courses.format"
        $Log = "$LogsDir/courses.log"
    }
}

Write-Host "FileBot: Renaming $Type..." -ForegroundColor Cyan
Write-Host "Input: $Input"
Write-Host "Database: $DB"
Write-Host "Action: $Action"
Write-Host "Log: $Log"
Write-Host ""

filebot -rename $Input `
    --db $DB `
    --format $Format `
    -non-strict `
    --log-file $Log `
    --action $Action

Write-Host ""
Write-Host "Done! Check log: $Log" -ForegroundColor Green
