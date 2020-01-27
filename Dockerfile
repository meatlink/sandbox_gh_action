FROM alpine:3.11.3 as ruby
COPY Gemfile /Gemfile
RUN apk add --no-cache g++ musl-dev make
RUN apk add --no-cache ruby ruby-dev ruby-bundler ruby-json ruby-bigdecimal
RUN bundle install
RUN apk del g++ musl-dev make

FROM alpine:3.11.3 as rust
RUN apk add --no-cache rust cargo
RUN cargo install mdbook

FROM scratch
COPY --from=ruby / /
COPY --from=rust /root/.cargo/bin/mdbook /mdbook
COPY action.sh /action.sh
ENTRYPOINT ["sh", "/action.sh"]
