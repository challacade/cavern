@echo off
:: ============================================================================
:: Cavern - Web Build Script (Windows)
::
:: Packages the cavern project into a .love archive, then converts it into a
:: browser-playable bundle using love.js. Output goes to build/web-output/.
::
:: Requirements: Node.js (https://nodejs.org/) -- love.js is fetched via npx.
:: ============================================================================

setlocal
set PROJECT_NAME=Cavern
set LOVE_FILE=game.love
set OUTPUT_DIR=web-output
:: Memory allocated to the WebAssembly heap. Must be >= the total size of
:: bundled assets. Cavern's assets are ~18 MB; 64 MB leaves comfortable
:: headroom for runtime allocations.
set LOVEJS_MEMORY=67108864

:: Run from build/ regardless of where the script is invoked from.
cd /d %~dp0
set BUILD_DIR=%CD%
cd ..
set PROJECT_ROOT=%CD%

echo ========================================
echo Cavern Web Build
echo ========================================
echo Project root: %PROJECT_ROOT%
echo Build dir:    %BUILD_DIR%
echo.

:: Clean up previous artifacts.
if exist "%BUILD_DIR%\%LOVE_FILE%"   del /q "%BUILD_DIR%\%LOVE_FILE%"
if exist "%BUILD_DIR%\%OUTPUT_DIR%"  rmdir /s /q "%BUILD_DIR%\%OUTPUT_DIR%"

:: Verify Node.js is available (needed for npx love.js).
where node >nul 2>nul
if errorlevel 1 (
    echo ERROR: Node.js not found in PATH.
    echo Install it from https://nodejs.org/ and re-open this terminal.
    exit /b 1
)

:: Build game.love by zipping the project. PowerShell's Compress-Archive only
:: accepts .zip output, so we write to a temp .zip then rename to .love.
echo Packaging project into %LOVE_FILE%...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$src = @('main.lua','conf.lua','source','sprites','fonts','sounds','music','maps') | Where-Object { Test-Path $_ };" ^
    "if (-not $src) { Write-Error 'No source files found to package'; exit 1 };" ^
    "$tmp = Join-Path '%BUILD_DIR%' 'game.zip';" ^
    "if (Test-Path $tmp) { Remove-Item $tmp -Force };" ^
    "Compress-Archive -Path $src -DestinationPath $tmp -Force;" ^
    "Move-Item -Force $tmp (Join-Path '%BUILD_DIR%' '%LOVE_FILE%')"
if errorlevel 1 (
    echo ERROR: Failed to package %LOVE_FILE%.
    exit /b 1
)

:: Convert the .love archive to a web bundle.
cd /d "%BUILD_DIR%"
echo.
echo Converting %LOVE_FILE% to web bundle (first run downloads love.js)...
echo Command: npx --yes love.js.cmd -m %LOVEJS_MEMORY% -t "%PROJECT_NAME%" -c %LOVE_FILE% %OUTPUT_DIR%
echo.
call npx --yes love.js.cmd -m %LOVEJS_MEMORY% -t "%PROJECT_NAME%" -c %LOVE_FILE% %OUTPUT_DIR%
set LOVEJS_EXIT=%ERRORLEVEL%
echo.
echo love.js exit code: %LOVEJS_EXIT%

if not exist "%OUTPUT_DIR%\index.html" (
    echo.
    echo ERROR: love.js did not produce %OUTPUT_DIR%\index.html.
    echo Output directory contents:
    if exist "%OUTPUT_DIR%" (
        dir /b "%OUTPUT_DIR%"
    ) else (
        echo   ^(directory was not created^)
    )
    echo.
    echo Try running the command manually to see full output:
    echo   cd /d "%BUILD_DIR%"
    echo   npx --yes love.js.cmd -m %LOVEJS_MEMORY% -t "%PROJECT_NAME%" -c %LOVE_FILE% %OUTPUT_DIR%
    exit /b 1
)

:: Replace love.js's default index.html with our minimal centered template.
:: We also drop the theme/ folder since the template no longer uses love.css.
echo.
echo Applying clean index.html template...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$tpl = Get-Content -Raw 'index.template.html';" ^
    "$tpl = $tpl.Replace('__TITLE__', '%PROJECT_NAME%').Replace('__MEMORY__', '%LOVEJS_MEMORY%');" ^
    "Set-Content -NoNewline -Encoding UTF8 -Path '%OUTPUT_DIR%\index.html' -Value $tpl"
if errorlevel 1 (
    echo ERROR: Failed to apply index.html template.
    exit /b 1
)
if exist "%OUTPUT_DIR%\theme" rmdir /s /q "%OUTPUT_DIR%\theme"

echo.
echo ========================================
echo Build complete: %BUILD_DIR%\%OUTPUT_DIR%\
echo Run web-run.bat to test in a browser.
echo ========================================
endlocal
