@echo off

rem Run this script where you would like to install Cygwin (e.g. C:\cygwin)

set root=%~dp0
set cygbin=%root%bin\

echo Downloading cygwin-setup-x86.exe
bitsadmin.exe /transfer "DownloadCygwin" https://cygwin.com/setup-x86.exe %root%/setup-x86.exe

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

echo Downloading and installing apt-cyg
%cygbin%lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
%cygbin%install apt-cyg /bin

echo Installing programs
cd /D %cygbin%
set aptcyg=bash.exe --login apt-cyg

echo Installing wget 
rem Insall wget first so apt-cyg does not have to use lynx as a backup.
%aptcyg% install wget

echo Installing etc packages
%aptcyg% install curl
%aptcyg% install pdftk
%aptcyg% install tmux
%aptcyg% install vim

echo Installing gcc-core packages
%aptcyg% install gcc-core
%aptcyg% install gcc-g++
%aptcyg% install gdb
%aptcyg% install make
%aptcyg% install libltdl

echo Installing git packages
%aptcyg% install git
%aptcyg% install git-completion

echo Installing rxvt-unicode packages
%aptcyg% install rxvt-unicode
%aptcyg% install fontconfig
%aptcyg% install ncurses
%aptcyg% install dejavu-fonts
%aptcyg% install font-bh-lucidatypewriter-dpi100
%aptcyg% install xorg-x11-fonts-dpi100

echo Installing xorg-server packages
%aptcyg% install xorg-server
%aptcyg% install xinit
%aptcyg% install xorg-docs
%aptcyg% install X-start-menu-icons