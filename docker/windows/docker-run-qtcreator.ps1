Param(
  [string]$IpAddress = "129.27.146.98"
)

docker run -it `
  --privileged `
  -e DISPLAY=${IpAddress}:0.0 `
  --name qt-creator `
  jdobaj/qt-dev:qtcreator `
  qtcreator

# --cpus="0.1"