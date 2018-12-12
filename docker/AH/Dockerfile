# docker build --build-arg request_domain=mydomain Dockerfile

FROM debian as build

# distro basics
RUN apt-get update && apt-get -y install sudo apt-utils
RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get -y autoclean

# build essentials
RUN apt-get -y install gcc g++ gdb cmake make build-essential

# qt libraries + qtcreator
RUN apt-get install qt5-default qt4-dev-tools qtcreator

# Set environment variables (XServer is linux only)
ENV DISPLAY unix$DISPLAY


FROM golang:1.7.3 as builder
WORKDIR /go/src/github.com/alexellis/href-counter/
RUN go get -d -v golang.org/x/net/html  
COPY app.go    .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/alexellis/href-counter/app .
CMD ["./app"]  