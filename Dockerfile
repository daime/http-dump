FROM golang:1.10.3 AS builder

WORKDIR /go/src/github.com/daime/http-dump

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o http-dump .

FROM scratch

WORKDIR /root/

COPY --from=0 /go/src/github.com/daime/http-dump/http-dump .

EXPOSE 8080

CMD ["./http-dump"]
