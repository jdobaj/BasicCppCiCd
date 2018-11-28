Param(
  [string]$IpAddress = "129.27.146.98",
  [string]$DevDir = "./../../",
  [string]$StorageDir = "./../../../docker-persistent-storage-as-bind-mount"
)

$DevDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($DevDir)
$StorageDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($StorageDir)

# Manage data in docker: https://docs.docker.com/storage/

docker run -it `
  --privileged `
  --mount "type=bind,source=${DevDir},target=/home/developer/BasicCppCiCd" `
  -e DISPLAY=${IpAddress}:0.0 `
  --name qt-sh `
  jdobaj/qt-dev:qtcreator

# --cpus="0.1"