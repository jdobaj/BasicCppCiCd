::docker build -t jdobaj/qt .
docker build --target build-env --file Dockerfile --tag jdobaj/qt-build-env --label v1.0 .
::docker build --no-cache -t jdobaj/qt -f jdobaj/qt-dev .
