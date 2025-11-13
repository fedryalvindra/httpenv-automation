# Stage untuk testing / build
FROM golang:1.21-alpine AS test
WORKDIR /app
COPY httpenv.go .
RUN go build -o httpenv httpenv.go

# Stage final
FROM alpine:latest
RUN addgroup -g 1000 httpenv \
    && adduser -u 1000 -G httpenv -D httpenv
COPY --from=test --chown=httpenv:httpenv /app/httpenv /httpenv
EXPOSE 8888
USER httpenv
CMD ["/httpenv"]
