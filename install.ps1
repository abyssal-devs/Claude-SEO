# Claude SEO Installer for Windows
# PowerShell installation script
#
# Usage:
#   irm https://raw.githubusercontent.com/abyssal-devs/Claude-SEO/main/install.ps1 | iex
#   # or, after cloning:
#   .\install.ps1
#
# Overrides (environment variables):
#   $env:CLAUDE_SEO_BRANCH = 'some-branch'   # default: main
#   $env:CLAUDE_SEO_KEEP_TEMP = '1'          # keep the temp clone on failure

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "|   Claude SEO - Installer             |" -ForegroundColor Cyan
Write-Host "|   Claude Code SEO Skills             |" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

function Invoke-External {
    param(
        [Parameter(Mandatory = $true)][string]$Exe,
        [Parameter(Mandatory = $true)][string[]]$Args,
        [switch]$Quiet
    )

    $previousErrorActionPreference = $ErrorActionPreference
    $hasNativePreference = $null -ne (Get-Variable -Name PSNativeCommandUseErrorActionPreference -ErrorAction SilentlyContinue)
    if ($hasNativePreference) {
        $previousNativePreference = $PSNativeCommandUseErrorActionPreference
    }

    try {
        $ErrorActionPreference = 'Continue'
        if ($hasNativePreference) {
            $PSNativeCommandUseErrorActionPreference = $false
        }

        $output = & $Exe @Args 2>&1 | ForEach-Object { $_.ToString() }
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $previousErrorActionPreference
        if ($hasNativePreference) {
            $PSNativeCommandUseErrorActionPreference = $previousNativePreference
        }
    }

    if (-not $Quiet -and $null -ne $output -and $output.Count -gt 0) {
        $output | ForEach-Object { Write-Host $_ }
    }

    return @{ ExitCode = $exitCode; Output = $output }
}

function Test-PythonCandidate {
    param(
        [Parameter(Mandatory = $true)][string]$Exe,
        [Parameter(Mandatory = $true)][string[]]$Args
    )

    $pythonCmd = Get-Command -Name $Exe -ErrorAction SilentlyContinue
    if ($null -eq $pythonCmd) {
        return $null
    }

    $probeCode = 'import sys; print(sys.executable); print(sys.version.split()[0])'
    $probe = Invoke-External -Exe $Exe -Args @($Args + @('-c', $probeCode)) -Quiet
    $probeText = ($probe.Output -join "`n")

    if ($probe.ExitCode -ne 0) {
        return $null
    }

    if ($probeText -match 'Microsoft Store|WindowsApps|App execution alias|was not found') {
        return $null
    }

    return @{ Exe = $Exe; Args = $Args }
}

function Resolve-Python {
    $candidates = @(
        @{ Exe = 'py'; Args = @('-3') },
        @{ Exe = 'python3'; Args = @() },
        @{ Exe = 'python'; Args = @() }
    )

    foreach ($candidate in $candidates) {
        $resolved = Test-PythonCandidate -Exe $candidate.Exe -Args $candidate.Args
        if ($null -ne $resolved) {
            return $resolved
        }
    }

    return $null
}

# Check prerequisites ---------------------------------------------------------
$python = Resolve-Python
if ($null -eq $python) {
    Write-Host "[!] Python was not found (tried 'py -3', 'python3', 'python')." -ForegroundColor Yellow
    Write-Host "    Skills install fine without it, but Python-backed scripts" -ForegroundColor Yellow
    Write-Host "    (visual analysis, drift, backlinks helpers) will be unavailable." -ForegroundColor Yellow
} else {
    try {
        $pythonVersion = & $python.Exe @($python.Args + @('--version')) 2>&1
        Write-Host "[+] $pythonVersion detected" -ForegroundColor Green
    } catch {
        Write-Host "[!] Python found but could not be executed; continuing without it." -ForegroundColor Yellow
        $python = $null
    }
}

try {
    git --version | Out-Null
    Write-Host "[+] Git detected" -ForegroundColor Green
} catch {
    Write-Host "[x] Git is required but not installed." -ForegroundColor Red
    exit 1
}

# Paths -----------------------------------------------------------------------
$SkillsDir = "$env:USERPROFILE\.claude\skills"
$AgentDir  = "$env:USERPROFILE\.claude\agents"
$RepoUrl   = "https://github.com/abyssal-devs/Claude-SEO.git"
$Branch    = if ($env:CLAUDE_SEO_BRANCH) { $env:CLAUDE_SEO_BRANCH } else { 'main' }

New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
New-Item -ItemType Directory -Force -Path $AgentDir  | Out-Null

# Temp clone ------------------------------------------------------------------
$TempDir = Join-Path $env:TEMP "claude-seo-install"
if (Test-Path $TempDir) {
    Remove-Item -Recurse -Force $TempDir
}

$keepTemp = ($env:CLAUDE_SEO_KEEP_TEMP -eq '1')

try {
    Write-Host ">> Downloading Claude SEO ($Branch)..." -ForegroundColor Yellow
    $clone = Invoke-External -Exe 'git' -Args @('clone','--depth','1','--branch',$Branch,$RepoUrl,$TempDir) -Quiet
    if ($clone.ExitCode -ne 0) {
        throw "git clone failed. Output:`n$($clone.Output -join "`n")"
    }

    # Install skills (each subfolder of skills/ -> ~/.claude/skills/<name>) ----
    Write-Host "=> Installing skills..." -ForegroundColor Yellow
    $SkillsSource = Join-Path $TempDir 'skills'
    if (-not (Test-Path $SkillsSource)) {
        throw "Could not find 'skills' folder in repo clone."
    }
    $skillCount = 0
    Get-ChildItem -Directory $SkillsSource | ForEach-Object {
        $target = Join-Path $SkillsDir $_.Name
        New-Item -ItemType Directory -Force -Path $target | Out-Null
        Copy-Item -Recurse -Force "$($_.FullName)\*" $target
        $skillCount++
    }
    Write-Host "   $skillCount skill(s) installed." -ForegroundColor Gray

    # Install subagents (agents/*.md -> ~/.claude/agents) ---------------------
    Write-Host "=> Installing subagents..." -ForegroundColor Yellow
    $AgentsSource = Join-Path $TempDir 'agents'
    if (Test-Path $AgentsSource) {
        Copy-Item -Force (Join-Path $AgentsSource '*.md') $AgentDir -ErrorAction SilentlyContinue
        $agentCount = (Get-ChildItem -File -Filter '*.md' $AgentsSource | Measure-Object).Count
        Write-Host "   $agentCount subagent(s) installed." -ForegroundColor Gray
    }

    # Install Python dependencies ---------------------------------------------
    $reqFile = Join-Path $SkillsDir 'seo\requirements.txt'
    if ($null -ne $python -and (Test-Path $reqFile)) {
        Write-Host "=> Installing Python dependencies..." -ForegroundColor Yellow
        try {
            $pip = Invoke-External -Exe $python.Exe -Args @($python.Args + @('-m','pip','install','-q','-r',$reqFile)) -Quiet
            if ($pip.ExitCode -ne 0) {
                throw ($pip.Output -join "`n")
            }
        } catch {
            Write-Host "  [!] Could not auto-install Python packages." -ForegroundColor Yellow
            Write-Host "  Try: $($python.Exe) $($python.Args -join ' ') -m pip install -r `"$reqFile`"" -ForegroundColor Yellow
        }

        # Optional: Playwright browsers (for visual analysis)
        Write-Host "=> Installing Playwright browsers (optional, for visual analysis)..." -ForegroundColor Yellow
        try {
            $pw = Invoke-External -Exe $python.Exe -Args @($python.Args + @('-m','playwright','install','chromium')) -Quiet
            if ($pw.ExitCode -ne 0) {
                throw ($pw.Output -join "`n")
            }
        } catch {
            Write-Host "  [!] Playwright install failed. Visual analysis will use WebFetch fallback." -ForegroundColor Yellow
        }
    } elseif ($null -eq $python) {
        Write-Host "  [!] Skipping Python dependencies (Python not available)." -ForegroundColor Yellow
    }
} catch {
    Write-Host ""
    Write-Host "[x] Installation failed: $($_.Exception.Message)" -ForegroundColor Red
    if ($keepTemp -and (Test-Path $TempDir)) {
        Write-Host "Temp dir kept at: $TempDir" -ForegroundColor Yellow
    }
    throw
} finally {
    if (-not $keepTemp -and (Test-Path $TempDir)) {
        Remove-Item -Recurse -Force $TempDir
    }
}

Write-Host ""
Write-Host "[+] Claude SEO installed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Usage:" -ForegroundColor Cyan
Write-Host "  1. Start Claude Code:  claude"
Write-Host "  2. Run a skill:        /seo audit https://example.com"
Write-Host ""
Write-Host "Skills location: $SkillsDir" -ForegroundColor Gray
Write-Host "Agents location: $AgentDir" -ForegroundColor Gray
