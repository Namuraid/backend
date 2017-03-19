FROM elixir:slim

ENV DEBIAN_FRONTEND=noninteractive

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

ENV APP_HOME /app/
WORKDIR $APP_HOME

ADD mix.exs $APP_HOME
RUN mix deps.get

ADD . $APP_HOME
