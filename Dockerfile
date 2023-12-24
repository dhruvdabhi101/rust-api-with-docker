# build stage 
FROM rust:1.69-buster as builder

WORKDIR /app

# accept the build arguments
ARG DATABASAE_URL

ENV DATABASE_URL=$DATABASAE_URL

COPY . .

RUN cargo build --release


# production stage
FROM debian:buster-slim

WORKDIR /usr/local/bin

COPY --from=builder /app/target/release/rust-crud-api .

CMD ["./rust-crud-api"]
