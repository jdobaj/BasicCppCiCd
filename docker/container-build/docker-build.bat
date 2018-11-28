::docker build -t jdobaj/qt .
docker build --no-cache -t jdobaj/qt-dev  .
::docker build --no-cache -t jdobaj/qt -f jdobaj/qt-dev .
