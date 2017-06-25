defmodule Namuraid.LiveFeedChannel do
  use Phoenix.Channel

  def join("livefeed", _params, socket) do
    {:ok, %{
      "token" => Namuraid.State.get(:fbtoken),
      "pageId" => Namuraid.State.get(:fbpageid)
    }, socket}
  end
end
