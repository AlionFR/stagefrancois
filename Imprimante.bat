@echo off

setlocal enabledelayedexpansion
chcp 1252 > nul
@echo.
@echo.

for /l %%x in (50,1,200) do (
@echo.
@echo.
    set "ip=10.121.5.%%x"
    ping -n 1 !ip! | find "TTL=" > nul
    if errorlevel 1 (
        echo pas d'imprimantes
    ) else (
        for /f "tokens=1-4 delims= " %%d in ('snmpwalk -v1 -c public !ip! sysDescr.0') do set marqueImprim=%%g
        echo !marqueImprim!
        if !marqueImprim!==Lexmark (
            for /f "tokens=1-4 delims= " %%d in ('snmpwalk -v1 -c public !ip! 1.3.6.1.2.1.43.11.1.1.8.1.2') do set lvlMAX=%%g
            echo !lvlMAX!

            for /f "tokens=1-4 delims= " %%d in ('snmpwalk -v1 -c public !ip! 1.3.6.1.2.1.43.11.1.1.9.1.2') do set lvlNOW=%%g
            echo !lvlNOW!

            for /f %%n in ('cscript //nologo eval.vbs "!lvlNOW!/!lvlMAX!*100"') do set lvlBDD=%%n
            echo lvlBDD = lvlNOW/lvlMAX*100 = !lvlBDD!

            for /f "tokens=1-4 delims= " %%d in ('snmpwalk -v1 -c public !ip! sysName.0') do set name=%%g
            echo !name!

            for /f "tokens=1-6 delims= " %%d in ('snmpwalk -v1 -c public !ip! sysLocation.0') do set location=%%g %%h %%i
            echo !location!

            set "test="
            for /f %%n in ('mysql -u printersink printersink -h localhost -e "SELECT * FROM printers WHERE name = '!name!'"') do set test=%%n

            if "!test!"=="" (
                mysql -u printersink printersink -h localhost -e "INSERT INTO `printersink`.`printers`(name, ip, ink, location, last_updated) VALUES('!name!', '!ip!', '!lvlBDD!', '!location!', '!date0!');"
            ) else (
                mysql -u printersink printersink -h localhost -e "UPDATE `printersink`.`printers` SET `ip` = '!ip!', `location` = '!location!', `ink` = '!lvlBDD!', `last_updated` = '!date0!' WHERE `printers`.`name` = '!name!';"
            )

        ) else if !marqueImprim!==KYOCERA (
            for /f "tokens=1-4 delims= " %%d in ('snmpwalk -v1 -c public !ip! 1.3.6.1.2.1.43.11.1.1.8.1.1') do set lvlMAX=%%g
            echo !lvlMAX!
            
            for /f "tokens=1-4 delims= " %%d in ('snmpwalk -v1 -c public !ip! 1.3.6.1.2.1.43.11.1.1.9.1.1') do set lvlNOW=%%g
            echo !lvlNOW!

            for /f "tokens=1-4 delims= " %%d in ('snmpwalk -v1 -c public !ip! 1.3.6.1.4.1.1347.40.10.1.1.5') do set name=%%g
            echo !name:~1,-1!

            for /f "tokens=1-6 delims= " %%d in ('snmpwalk -v1 -c public !ip! sysLocation.0') do set location=%%g %%h %%i
            echo !location!

            set date0=%date:~-4%-%date:~3,2%-%date:~0,2% %time:~0,2%:%time:~3,2%:%time:~6,2%
            echo !date0!
            
            for /f %%n in ('cscript //nologo eval.vbs "!lvlNOW!/!lvlMAX!*100"') do set lvlBDD=%%n
            echo lvlBDD1 = lvlNOW/lvlMAX*100 = !lvlBDD!

            mysql -u printersink printersink -h localhost -e "SELECT * FROM printers WHERE `printers`.`name` = '!name:~1,-1!'"


            set "test="
            for /f %%n in ('mysql -u printersink printersink -h localhost -e "SELECT * FROM printers WHERE `printers`.`name` = '!name:~1,-1!'"') do set test=%%n  

            echo !ip!


            if "!test!"=="" (
                echo oui
                mysql -u printersink printersink -h localhost -e "INSERT INTO `printersink`.`printers`(name, ip, ink, location, last_updated) VALUES('!name:~1,-1!', '!ip!', '!lvlBDD!', '!location!', '!date0!');"
            ) else (
                echo non
                echo !test!
                mysql -u printersink printersink -h localhost -e "UPDATE `printersink`.`printers` SET `ip` = '!ip!', `location` = '!location!', `ink` = '!lvlBDD!', `last_updated` = '!date0!' WHERE `printers`.`name` = '!name:~1,-1!';"
            )

        ) else if !marqueImprim!==Xerox (
            for /f "tokens=1-4 delims= " %%d in ('snmpwalk -v1 -c public !ip! 1.3.6.1.2.1.43.11.1.1.8.1.1') do set lvlMAX=%%g
            echo !lvlMAX!
            
            for /f "tokens=1-4 delims= " %%d in ('snmpwalk -v1 -c public !ip! 1.3.6.1.2.1.43.11.1.1.9.1.1') do set lvlNOW=%%g
            echo !lvlNOW!

            for /f %%n in ('cscript //nologo eval.vbs "!lvlNOW!/!lvlMAX!*100"') do set lvlBDD=%%n
            echo lvlBDD = lvlNOW/lvlMAX*100 = !lvlBDD!

            for /f "tokens=1-4 delims= " %%d in ('snmpwalk -v1 -c public !ip! sysName.0') do set name=%%g
            echo !name!

            for /f "tokens=1-6 delims= " %%d in ('snmpwalk -v1 -c public !ip! sysLocation.0') do set location=%%g %%h %%i
            echo !location!

            set "test="
            for /f %%n in ('mysql -u printersink printersink -h localhost -e "SELECT * FROM printers WHERE name = '!name!'"') do set test=%%n

            if "!test!"=="" (
                mysql -u printersink printersink -h localhost -e "INSERT INTO `printersink`.`printers`(name, ip, ink, location, last_updated) VALUES('!name!', '!ip!', '!lvlBDD!', '!location!', '!date0!');"
            ) else (
                mysql -u printersink printersink -h localhost -e "UPDATE `printersink`.`printers` SET `ip` = '!ip!', `location` = '!location!', `ink` = '!lvlBDD!', `last_updated` = '!date0!' WHERE `printers`.`name` = '!name!';"
            )


        )
    )
)
