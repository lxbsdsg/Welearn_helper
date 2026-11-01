param(
    [string]$Python = "python"
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot

Push-Location $root
try {
    & $Python -m pip install --disable-pip-version-check -r requirement.txt -r requirements-dev.txt
    if ($LASTEXITCODE -ne 0) { throw "依赖安装失败" }

    & $Python -m PyInstaller `
        --noconfirm --clean `
        --onefile --console `
        --name WelearnHelper `
        --distpath dist `
        --workpath build `
        web_gui.py
    if ($LASTEXITCODE -ne 0) { throw "PyInstaller 打包失败" }

    Write-Host "打包完成: $root\dist\WelearnHelper.exe"
} finally {
    Pop-Location
}
