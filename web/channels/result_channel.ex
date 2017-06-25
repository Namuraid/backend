defmodule Namuraid.ResultChannel do
  use Phoenix.Channel

  def join("result", _params, socket) do
    {:ok, %{
      "token" => Namuraid.State.get(:fbtoken),
      "pageId" => Namuraid.State.get(:fbpageid)
    }, socket}
  end
end
