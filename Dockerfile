FROM ruby
COPY Gemfile /Gemfile
RUN bundle install
RUN \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rustup.sh ; \
    sh /tmp/rustup.sh -y ; \
    . $HOME/.cargo/env ; \
    cargo install mdbook
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]
