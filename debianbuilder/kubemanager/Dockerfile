FROM golang:1.14-buster as build
RUN go get github.com/michaelhenkel/kube-manager
RUN go build -o /go/bin/kube_manager /go/src/github.com/michaelhenkel/kube-manager/main.go
FROM gcr.io/distroless/base-debian10:debug
COPY --from=build /go/bin/kube_manager /
