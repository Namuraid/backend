defmodule Namuraid.ScreenChannel do
    use Phoenix.Channel

    def join("*", _message, socket) do
        { :ok, socket }
    end
end