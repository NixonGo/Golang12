FROM golang:1.25-alpine AS builder

WORKDIR /app
COPY . .

RUN go mod init app || true
RUN go mod tidy
RUN go build -o app .

FROM alpine:latest
WORKDIR /root/

COPY --from=builder /app/app .

COPY --from=builder /app/tracker.db .

CMD ["./app"]