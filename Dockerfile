# Étape 1 : Builder Plik
FROM golang:1.20-alpine AS builder

RUN apk add --no-cache git bash

WORKDIR /app

COPY . .

# ⚠️ On ne lance pas releaser.sh
# RUN releaser/releaser.sh

# Build du binaire Plik
RUN go build -o plik ./cmd/plik

# Étape 2 : Image finale
FROM alpine:latest

WORKDIR /app

# Copier le binaire et fichiers nécessaires
COPY --from=builder /app/plik /app/plik
COPY --from=builder /app/public /app/public
COPY --from=builder /app/config /app/config

EXPOSE 80

CMD ["/app/plik"]
