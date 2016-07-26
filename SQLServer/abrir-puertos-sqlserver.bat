@echo off

@echo =========  Puertos SQL Server  ===================

@echo Habilitando puerto 1433 predeterminado de la instancia SQL Server
::netsh firewall set portopening TCP 1433 "SQL Server"
netsh advfirewall firewall add rule name="SQL Server" dir=in action=allow protocol=TCP localport=1433

@echo Habilitando puerto de conexión 1434 de administración dedicado
::netsh firewall set portopening TCP 1434 "SQL Admin Connection"
netsh advfirewall firewall add rule name="SQL Admin Connection" dir=in action=allow protocol=TCP localport=1434

@echo Habilitando puerto convencional 4022 de SQL Server Service Broker
::netsh firewall set portopening TCP 4022 "SQL Service Broker"
netsh advfirewall firewall add rule name="SQL Service Broker" dir=in action=allow protocol=TCP localport=4022

@echo Habilitando puerto 135 de Transact-SQL Debugger/RPC
::netsh firewall set portopening TCP 135 "SQL Debugger/RPC"
netsh advfirewall firewall add rule name="SQL Debugger/RPC" dir=in action=allow protocol=TCP localport=135


@echo =========  Puertos Analysis Services  ==============

@echo Habilitando puerto 2383 de la instancia por defecto de SSAS
::netsh firewall set portopening TCP 2383 "Analysis Services"
netsh advfirewall firewall add rule name="Analysis Services" dir=in action=allow protocol=TCP localport=2383

@echo Habilitando puerto 2382 de SQL Server Browser Service
::netsh firewall set portopening TCP 2382 "SQL Browser"
netsh advfirewall firewall add rule name="SQL Browser" dir=in action=allow protocol=TCP localport=2382

@echo =========  Misc Applications  ==============

@echo Habilitando puerto 80 HTTP
::netsh firewall set portopening TCP 80 "HTTP"
netsh advfirewall firewall add rule name="HTTP" dir=in action=allow protocol=TCP localport=80

@echo Habilitando puerto 443 SSL
::netsh firewall set portopening TCP 443 "SSL"
netsh advfirewall firewall add rule name="SSL" dir=in action=allow protocol=TCP localport=443

@echo Habilitando puerto de SQL Server Browser Service
::netsh firewall set portopening UDP 1434 "SQL Browser"
netsh advfirewall firewall add rule name="SQL Browser" dir=in action=allow protocol=UDP localport=1434

@echo Permitiendo una respuesta de difusión multidifusión en UDP (Navegador de servicios enumeraciones OK)
::netsh firewall set multicastbroadcastresponse ENABLE
netsh advfirewall set currentprofile settings unicastresponsetomulticast enable
