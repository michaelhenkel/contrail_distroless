FROM golang:1.14-buster as build

#WORKDIR /go/src/github.com/michaelhenkel/contrail-init

RUN go get github.com/michaelhenkel/contrail-init

RUN go build -o /go/bin/contrail-init /go/src/github.com/michaelhenkel/contrail-init

# Now copy it into our base image.
FROM gcr.io/distroless/base-debian10:debug
COPY --from=build /go/bin/contrail-init /
