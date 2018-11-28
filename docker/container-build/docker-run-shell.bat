set YOUR_IP_ADDRESS=%1

:: Create the container with all options needed to let a GUI program
:: like qtcreator connect to the host xorg server. On windows this
:: requires an XServer such VxXsrv
:: The c:/VC directory is mounted directly into the container.
docker run -it ^
	--privileged ^
	-v c:/VC:/home/VC ^
	-e DISPLAY=%YOUR_IP_ADDRESS%:0.0 ^
	--name qt-sh ^
	jdobaj/qt-dev:qtcreator

::--cpus="0.1" ^