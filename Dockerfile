FROM golang:1.14.0 AS builder

WORKDIR /go/src/github.com/daime/http-dump

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o http-dump .

FROM marcosmorelli/debian-base-image

WORKDIR /root/

COPY --from=0 /go/src/github.com/daime/http-dump/http-dump .

EXPOSE 8080

CMD ["./http-dump"]
