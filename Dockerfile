# Stage untuk testing
FROM golang:alpine AS test
COPY httpenv.go /go
RUN go build httpenv.go

# Stage final
FROM alpine
RUN addgroup -g 1000 httpenv \
    && adduser -u 1000 -G httpenv -D httpenv
COPY --from=test --chown=httpenv:httpenv /go/httpenv /httpenv
EXPOSE 8888
CMD ["/httpenv"]
