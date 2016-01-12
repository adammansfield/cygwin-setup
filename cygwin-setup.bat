@echo off

rem Run this script where you would like to install Cygwin (e.g. C:\cygwin)

set root=%~dp0
set cygbin=%root%bin\

set do_install_cygwin=y
set /p do_install_cygwin=Install Cygwin in %root%? (Y/n)
if /I "%do_install_cygwin%"=="y" (
  if exist setup-x86.exe (
    echo Using existing setup-x86.exe
  ) else (
    bitsadmin.exe /transfer "DownloadCygwin" https://cygwin.com/setup-x86.exe %root%/setup-x86.exe
    echo Downloaded setup-x86.exe
  )

  echo.
  echo Installing base packages
  if not exist %root%/packages mkdir %root%/packages

  rem setup-x86.exe Options:
  rem   --categories        Install all packages of the specified category.
  rem   --root              Location of the Cygwin root directory.
  rem   --local-package-dir Location of the directory to download packages to.
  rem   --site              The site to download packages from.
  rem   --only-site         Only use the site specified, and do not request the default list of sites.
  rem   --wait              If launching a child process requiring admin, parent does not exit until child does.
  rem   --quiet-mode        Unattended setup mode.
  rem   --no-desktop        Do not install desktop shortcuts.
  rem   --no-shortcuts      Do not install shortcuts.
  rem   --no-startmenu      Do not install start menu shortcuts.
  setup-x86.exe --categories Base --root %root% --local-package-dir %root%packages --site http://mirrors.kernel.org/sourceware/cygwin --only-site --wait --quiet-mode --no-desktop --no-shortcuts --no-startmenu
)

if not exist %cygbin%\apt-cyg (
  echo.
  echo Downloading and installing apt-cyg
  %cygbin%lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
  %cygbin%install apt-cyg /bin
)

echo.
echo Installing programs
set PATH=%PATH%;%cygbin%

echo.
echo Installing wget 
rem Insall wget first so apt-cyg does not have to use lynx as a backup.
bash -c "apt-cyg install wget"

echo.
echo Installing etc packages
bash -c "apt-cyg install curl"
bash -c "apt-cyg install pdftk"
bash -c "apt-cyg install tmux"
bash -c "apt-cyg install vim"

echo.
echo Installing gcc-core packages
bash -c "apt-cyg install gcc-core"
bash -c "apt-cyg install gcc-g++"
bash -c "apt-cyg install gdb"
bash -c "apt-cyg install make"
bash -c "apt-cyg install libltdl"

echo.
echo Installing git packages
bash -c "apt-cyg install git"
bash -c "apt-cyg install git-completion"

echo.
echo Installing rxvt-unicode packages
bash -c "apt-cyg install rxvt"
bash -c "apt-cyg install rxvt-unicode"
bash -c "apt-cyg install fontconfig"
bash -c "apt-cyg install ncurses"
bash -c "apt-cyg install dejavu-fonts"
bash -c "apt-cyg install font-bh-lucidatypewriter-dpi100"
bash -c "apt-cyg install xorg-x11-fonts-dpi100"

echo.
echo Installing xorg-server packages
bash -c "apt-cyg install xorg-server"
bash -c "apt-cyg install xinit"
bash -c "apt-cyg install xorg-docs"
bash -c "apt-cyg install X-start-menu-icons"
