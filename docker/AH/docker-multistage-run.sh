xhost +
docker run -it \
	--privileged \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=unix$DISPLAY \
	--name qt-ops-ms-env \
	jdobaj/qt-ops-env:v2.0
