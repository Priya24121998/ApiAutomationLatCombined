@echo off
REM Check for Java
java -version
IF NOT %ERRORLEVEL% == 0 (
    echo Installing OpenJDK 11...
    powershell -Command "Invoke-WebRequest -Uri https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_windows-x64_bin.zip -OutFile openjdk.zip"
    powershell -Command "Expand-Archive openjdk.zip -DestinationPath C:\openjdk"
    setx PATH "C:\openjdk\bin;%PATH%"
)

REM Install Microsoft Edge
echo Installing Microsoft Edge...
powershell -Command "Invoke-WebRequest -Uri https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/2b6e2f1e-3b4e-4b6e-8b7e-2b6e2f1e3b4e/MicrosoftEdgeSetup.exe -OutFile MicrosoftEdgeSetup.exe"
start /wait MicrosoftEdgeSetup.exe /silent /install

REM Download Edge WebDriver
echo Downloading Edge WebDriver...
powershell -Command "Invoke-WebRequest -Uri https://msedgedriver.azureedge.net/114.0.1823.43/edgedriver_win64.zip -OutFile edgedriver.zip"
powershell -Command "Expand-Archive edgedriver.zip -DestinationPath C:\WebDriver"
setx PATH "C:\WebDriver;%PATH%"

REM Download Selenium Server
echo Downloading Selenium Server 4.9.0...
powershell -Command "Invoke-WebRequest -Uri https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.9.0/selenium-server-4.9.0.jar -OutFile C:\Selenium\selenium-server-4.9.0.jar"

REM Start Selenium Grid in standalone mode
echo Starting Selenium Grid...
java -jar C:\Selenium\selenium-server-4.9.0.jar standalone
