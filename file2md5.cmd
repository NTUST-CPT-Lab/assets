:: Change the name of the file to the md5 of the file for all files in the current directory
@echo off
setlocal enabledelayedexpansion

for %%f in (*) do (
    if not "%%~nxf"=="file2md5.cmd" (
        set "filename=%%~nf"
        set "extension=%%~xf"

        for /f "delims=" %%a in ('certutil -hashfile "%%f" MD5 ^| findstr /v "hash"') do (
            set "md5=%%a"
        )

        set "newname=!md5!!extension!"
        set "counter=1"
        :check_exists
        if exist "!newname!" (
            set "newname=!md5!_!counter!!extension!"
            set /a counter+=1
            goto :check_exists
        )

        echo Renaming "%%f" to "!newname!"
        ren "%%f" "!newname!"
    )
)

echo.s
echo All files have been renamed to their MD5 hashes.

endlocal

:: Press any key to exit
echo Press any key to exit...
pause >nul
