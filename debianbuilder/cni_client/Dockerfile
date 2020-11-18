FROM golang:1.14-buster as build
RUN go get github.com/michaelhenkel/contrail-cni/contrailcni_client
RUN go build -o /go/bin/contrail_cni_client /go/src/github.com/michaelhenkel/contrail-cni/contrailcni_client/client.go
FROM gcr.io/distroless/base-debian10:debug
COPY --from=build /go/bin/contrail_cni_client /
