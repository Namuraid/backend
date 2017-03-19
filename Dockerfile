FROM elixir

ENV DEBIAN_FRONTEND=noninteractive

run mix local.hex --force
run mix local.rebar --force
run  mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

ENV APP_HOME /app
RUN mkdir -p $APP_HOME

workdir $APP_HOME

add mix.exs $APP_HOME
run mix deps.get

add . $APP_HOME
