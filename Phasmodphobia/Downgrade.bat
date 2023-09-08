@echo off
set /p downloadLocation=Enter the path of the extracted Steam Depot Downloader: 
set /p username=Enter your Steam username: 
echo Your password is not stored anywhere, this is used to download the game's files straight from Steam
set /p password=Enter your Steam password: 

dotnet "%downloadLocation%\DepotDownloader.dll" -app 739630 -depot 739631 -manifest 2393199652183266332 -username %username% -password %password%
pause
