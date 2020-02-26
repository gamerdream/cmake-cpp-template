@echo off
setlocal enabledelayedexpansion

:clean
:detect_target
set /a retry_count=1
set /a max_retry_count=100
set /a wait_seconds=5
set target_directory=%~dp0..\targets\
if not exist !target_directory! goto dir_notexist
:try_clean
echo -- Deleting target directory...
if !retry_count! geq !max_retry_count! goto dir_timeout
rd /s /q %target_directory%
if exist !target_directory! (
  echo -- Clean attempt failed #!retry_count!
  echo -- Waiting %wait_seconds% seconds...
  ping -n !wait_seconds! 127.0.0.1>nul
  echo -- Let's try deleting target directory again...
  set /a retry_count+=1
  goto try_clean
)
echo -- Target directory deleted
echo -- Clean SUCCESS
echo.
goto exit

:dir_notexist
echo -- Target directory does not exist.
echo -- There is nothing to clean.
goto exit

:dir_timeout
echo -- Failed to remove target directory, because another process is using it.
echo -- Please try again later...
echo -- Clean FAILURE
echo.
goto exit

:exit
echo.
endlocal
@echo on