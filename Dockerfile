FROM bitwalker/alpine-elixir-phoenix:1.13 AS builder

WORKDIR /app

COPY ./mix.exs ./
COPY ./mix.lock ./
COPY ./assets/css ./assets/css
COPY ./assets/js ./assets/js
COPY ./assets/static ./assets/static
COPY ./assets/package.json ./assets/package.json
COPY ./assets/package-lock.json ./assets/package-lock.json
COPY ./assets/tsconfig.json ./assets/tsconfig.json
COPY ./assets/postcss.config.js ./assets/postcss.config.js
COPY ./assets/tailwind.config.js ./assets/tailwind.config.js
COPY ./assets/webpack.config.js ./assets/webpack.config.js
COPY ./assets/babel.config.js ./assets/babel.config.js
COPY ./config ./config
COPY ./lib ./lib
COPY ./priv/repo ./priv/repo

RUN apk add --update alpine-sdk
RUN apk add --no-cache gcc musl-dev && apk add --no-cache rust cargo
RUN mix setup.deps
RUN mix compile

FROM bitwalker/alpine-elixir-phoenix:1.13

WORKDIR /app
COPY --from=builder /app .

ENTRYPOINT ["mix phx.server"]
