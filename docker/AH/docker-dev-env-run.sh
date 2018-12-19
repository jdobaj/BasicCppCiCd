xhost +
docker run -it \
	--privileged \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v `pwd`/QtExampleApp:/home/developer/QtExampleApp \
	-e DISPLAY=unix$DISPLAY \
	--entrypoint /bin/bash \
	--name qt-dev-env \
	jdobaj/qt-dev-env:v1.0
