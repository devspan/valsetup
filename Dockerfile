FROM ethereum/client-go:v1.13.15

RUN apk add --no-cache ca-certificates bash curl

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]