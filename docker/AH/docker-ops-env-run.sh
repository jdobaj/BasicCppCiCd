xhost +
docker run -it \
	--privileged \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ./QtExampleApp:/home/touchpanel/QtExampleApp \
	-e DISPLAY=unix$DISPLAY \
	--name qt-ops-env \
	jdobaj/qt-ops-env:v1.0
