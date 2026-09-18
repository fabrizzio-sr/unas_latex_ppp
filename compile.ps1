<#
.SYNOPSIS
  Script de automatización para compilar la plantilla de PPP UNAS con LuaLaTeX.
.DESCRIPTION
  Compila el documento aislando los archivos auxiliares en la subcarpeta 'build/',
  y copia el PDF generado a la raíz del proyecto con timestamp (informe_ppp_yyyyMMdd_HHmmss.pdf).
.EXAMPLE
  .\compile.ps1
  Compila el documento y genera informe_ppp_YYYYMMDD_HHMMSS.pdf y main.pdf en la raíz.
.EXAMPLE
  .\compile.ps1 -Clean
  Elimina la carpeta 'build/' y archivos auxiliares temporales.
.EXAMPLE
  .\compile.ps1 -Watch
  Ejecuta latexmk en modo observación continua hacia la carpeta 'build/'.
#>

[CmdletBinding()]
param(
  [switch]$Clean,
  [switch]$Watch
)

$ErrorActionPreference = "Stop"

$BuildDir = "build"
$BasePrefix = "informe_ppp_"

$AuxExtensions = @(
  "*.aux", "*.bbl", "*.bcf", "*.blg", "*.fdb_latexmk",
  "*.fls", "*.lof", "*.log", "*.lot", "*.out",
  "*.run.xml", "*.synctex.gz", "*.toc", "*.nav", "*.snm", "*.vrb"
)

function Clean-AuxFiles {
  Write-Host "[INFO] Limpiando carpeta de compilación '$BuildDir' y archivos auxiliares..." -ForegroundColor Cyan
  if (Test-Path $BuildDir) {
    Remove-Item -Path $BuildDir -Recurse -Force
    Write-Host "[OK] Carpeta '$BuildDir' eliminada." -ForegroundColor Green
  }
  foreach ($ext in $AuxExtensions) {
    Get-ChildItem -Path . -Filter $ext -File -ErrorAction SilentlyContinue | Remove-Item -Force
  }
  Write-Host "[OK] Limpieza completada con éxito." -ForegroundColor Green
}

if ($Clean) {
  Clean-AuxFiles
  exit 0
}

if ($Watch) {
  Write-Host "[INFO] Iniciando modo observación continua con LaTeXmk (Ctrl+C para salir)..." -ForegroundColor Cyan
  latexmk -pvc -outdir=$BuildDir -lualatex main.tex
  exit 0
}

Write-Host "========================================================" -ForegroundColor Magenta
Write-Host "  Compilador de Plantilla PPP UNAS (LuaLaTeX)" -ForegroundColor Magenta
Write-Host "========================================================" -ForegroundColor Magenta

# Asegurar la existencia de la carpeta build/
if (-not (Test-Path $BuildDir)) {
  New-Item -ItemType Directory -Force -Path $BuildDir | Out-Null
}

# Paso 1: Primera pasada LuaLaTeX hacia build/
Write-Host "`n[Paso 1/4] Ejecutando LuaLaTeX (primera pasada -> $BuildDir)..." -ForegroundColor Yellow
lualatex "-output-directory=$BuildDir" -interaction=nonstopmode -synctex=1 main.tex
if ($LASTEXITCODE -ne 0) {
  Write-Host "[ERROR] Falló la primera pasada de LuaLaTeX. Revise $BuildDir\main.log." -ForegroundColor Red
  exit $LASTEXITCODE
}

# Paso 2: Procesamiento de Referencias BibTeX en build/
Write-Host "[Paso 2/4] Procesando bibliografía con BibTeX..." -ForegroundColor Yellow
bibtex "$BuildDir/main"

# Paso 3: Segunda pasada LuaLaTeX para resolver citas
Write-Host "[Paso 3/4] Ejecutando LuaLaTeX (segunda pasada -> $BuildDir)..." -ForegroundColor Yellow
lualatex "-output-directory=$BuildDir" -interaction=nonstopmode -synctex=1 main.tex
if ($LASTEXITCODE -ne 0) {
  Write-Host "[ERROR] Falló la segunda pasada de LuaLaTeX." -ForegroundColor Red
  exit $LASTEXITCODE
}

# Paso 4: Tercera pasada LuaLaTeX para resolver referencias cruzadas e índices
Write-Host "[Paso 4/4] Ejecutando LuaLaTeX (tercera pasada e índices -> $BuildDir)..." -ForegroundColor Yellow
lualatex "-output-directory=$BuildDir" -interaction=nonstopmode -synctex=1 main.tex
if ($LASTEXITCODE -ne 0) {
  Write-Host "[ERROR] Falló la pasada final de LuaLaTeX." -ForegroundColor Red
  exit $LASTEXITCODE
}

# Generar Timestamp y copiar a la raíz
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$TimestampedFile = "$BasePrefix$Timestamp.pdf"

if (Test-Path "$BuildDir\main.pdf") {
  Copy-Item "$BuildDir\main.pdf" -Destination $TimestampedFile -Force
  Copy-Item "$BuildDir\main.pdf" -Destination "main.pdf" -Force

  Write-Host "`n========================================================" -ForegroundColor Green
  Write-Host "  [ÉXITO] Compilación finalizada correctamente" -ForegroundColor Green
  Write-Host "  -> Archivo con timestamp: $TimestampedFile" -ForegroundColor Cyan
  Write-Host "  -> Archivo sincronizado:  main.pdf" -ForegroundColor Cyan
  Write-Host "========================================================" -ForegroundColor Green
} else {
  Write-Host "[ERROR] No se encontró el archivo generado en $BuildDir\main.pdf." -ForegroundColor Red
  exit 1
}
