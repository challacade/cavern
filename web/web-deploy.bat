@echo off
:: ============================================================================
:: Cavern - Production Deploy Build
::
:: Builds the web bundle with <base href="/games/cavern/"> so that
:: the output can be hosted at challacade.com/games/cavern/ without
:: relative asset paths breaking on non-trailing-slash URLs.
::
:: For local testing use web-build.bat (no base href) + web-run.bat instead.
:: ============================================================================
call "%~dp0web-build.bat" /games/cavern/
