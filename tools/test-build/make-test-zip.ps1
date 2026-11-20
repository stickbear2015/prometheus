<#
.SYNOPSIS
  Makes a zip of the soundpack for testers, from what's committed on the current branch.

.DESCRIPTION
  The zip has the same layout as an installed pack: a mushclient folder (the pack)
  with changelog.html beside it, plus TESTING-README.txt telling the tester how to
  use it. Testers unzip it into a new folder and run mushclient\mushclient.exe; their
  normal pack and settings aren't touched.

  The zip is built from the last commit, never from the folder on disk, so local files
  (your Config.txt, game logs, temp-logs, test results) can't end up in it. If the pack
  has uncommitted changes, the script stops and asks you to commit first.

  The name is Prometheus-<label>-test-<date>-<commit>.zip, for example
  Prometheus-cleanup-test-20261120-a23dda8.zip. The label comes from the branch name
  (cleanup/tidy-pack gives "cleanup"), unless you give one. The commit at the end shows
  exactly which version a tester has.

.PARAMETER Label
  Word for the name instead of the one taken from the branch, for example "sounds".

.PARAMETER OutDir
  Where to put the zip. Defaults to the repo's top folder (git ignores zip files).

.EXAMPLE
  .\tools\test-build\make-test-zip.ps1

.EXAMPLE
  .\tools\test-build\make-test-zip.ps1 -Label sounds
#>
param(
    [string]$Label,
    [string]$OutDir
)

$ErrorActionPreference = 'Stop'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
if (-not $OutDir) { $OutDir = $repo }

Push-Location $repo
try {
    # Refuse to build if the pack has changes that aren't committed: the zip would not include them.
    $dirty = git status --porcelain -- prometheus changelog.html
    if ($dirty) {
        Write-Host "The pack has changes that aren't committed, so they wouldn't be in the zip:"
        $dirty | ForEach-Object { Write-Host "  $_" }
        Write-Host "Commit them first, then run this again."
        exit 1
    }

    $branch = (git rev-parse --abbrev-ref HEAD).Trim()
    $commit = (git rev-parse --short HEAD).Trim()
    if (-not $Label) {
        $Label = ($branch -split '/')[0]
        if ($Label -eq 'HEAD') { $Label = 'detached' }
    }
    $Label = ($Label -replace '[^A-Za-z0-9-]', '-').Trim('-')
    $date = Get-Date -Format 'yyyyMMdd'
    $zipName = "Prometheus-$Label-test-$date-$commit.zip"
    $zipPath = Join-Path $OutDir $zipName

    Write-Host "Building $zipName from branch $branch (commit $commit)..."

    # Export the committed pack and changelog into a temporary folder.
    $work = Join-Path ([System.IO.Path]::GetTempPath()) ("prometheus-test-" + [guid]::NewGuid().ToString('N'))
    $stage = Join-Path $work 'stage'
    New-Item -ItemType Directory -Path $stage | Out-Null
    $tarFile = Join-Path $work 'pack.tar'
    git archive --format=tar -o $tarFile HEAD prometheus changelog.html
    & "$env:SystemRoot\System32\tar.exe" -xf $tarFile -C $stage
    if ($LASTEXITCODE -ne 0) { throw "Couldn't unpack the exported files." }

    # Same layout as the installer: the pack goes in a folder called mushclient.
    Rename-Item -Path (Join-Path $stage 'prometheus') -NewName 'mushclient'
    Copy-Item -Path (Join-Path $PSScriptRoot 'TESTING-README.txt') -Destination $stage

    if (Test-Path $zipPath) { Remove-Item $zipPath }
    Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $zipPath -CompressionLevel Optimal

    $sizeMB = [math]::Round((Get-Item $zipPath).Length / 1MB)
    Write-Host "Done: $zipPath ($sizeMB MB)"
}
finally {
    if ($work -and (Test-Path $work)) { Remove-Item -Recurse -Force $work }
    Pop-Location
}
