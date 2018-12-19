xhost +
docker run -it \
	--privileged \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ./QtExampleApp:/home/developer/QtExampleApp \
	-e DISPLAY=unix$DISPLAY \
	--name qt-dev-env \
	jdobaj/qt-dev-env:v1.0
