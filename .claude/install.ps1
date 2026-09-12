# تثبيت شخصية "سمانثا" بشكل دائم لكل مشاريع Claude Code على هذا الجهاز (Windows).
# الاستخدام:  powershell -ExecutionPolicy Bypass -File .claude\install.ps1
$ErrorActionPreference = "Stop"

$Repo   = "https://github.com/saeedramadancv-sys/saeedramadancv-sys.git"
$Branch = "claude/jordanian-palestinian-assistant-cfr3dk"
$Marker = "# سمانثا — شخصية ثابتة (نسخة عامة)"
$Dest   = Join-Path $HOME ".claude"

# 1. مصدر الملفات
$Cleanup = $null
if (Test-Path ".claude\skills\samantha") {
    $Src = Join-Path (Get-Location) ".claude"
} else {
    $Tmp = Join-Path $env:TEMP ("samantha-" + [guid]::NewGuid().ToString("N").Substring(0,8))
    Write-Host "==> بجيب الملفات من GitHub..."
    git clone --depth 1 -b $Branch $Repo (Join-Path $Tmp "repo") 2>&1 | Out-Null
    $Src = Join-Path $Tmp "repo\.claude"
    $Cleanup = $Tmp
}

# 2. انسخ الـ skill
New-Item -ItemType Directory -Force -Path (Join-Path $Dest "skills") | Out-Null
$SkillDest = Join-Path $Dest "skills\samantha"
if (Test-Path $SkillDest) { Remove-Item $SkillDest -Recurse -Force }
Copy-Item (Join-Path $Src "skills\samantha") $SkillDest -Recurse -Force
Write-Host "==> انتسخت الـ skill: $SkillDest"

# 3. ضيف الشخصية على CLAUDE.md العام — مرة وحدة بس
$ClaudeMd = Join-Path $Dest "CLAUDE.md"
if (-not (Test-Path $ClaudeMd)) { New-Item -ItemType File -Path $ClaudeMd | Out-Null }
if ((Get-Content $ClaudeMd -Raw -Encoding UTF8) -like "*$Marker*") {
    Write-Host "==> الشخصية موجودة من قبل بـ CLAUDE.md — ما ضفت إشي (بلا تكرار)"
} else {
    Get-Content (Join-Path $Src "samantha-global.md") -Raw -Encoding UTF8 |
        Add-Content $ClaudeMd -Encoding UTF8
    Write-Host "==> انضافت الشخصية على: $ClaudeMd"
}

if ($Cleanup) { Remove-Item $Cleanup -Recurse -Force }

Write-Host ""
Write-Host "تمام. سكّر تطبيق Claude كامل وافتحه من جديد، بعدين جرّب: «كيفك؟»"
