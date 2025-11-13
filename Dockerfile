# Stage build
FROM golang:1.21 AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o httpenv main.go

# Stage test
FROM build AS test
RUN go test ./...

# Stage final
FROM golang:1.21 AS final
WORKDIR /app
COPY --from=build /app/httpenv .
EXPOSE 8888
CMD ["./httpenv"]
