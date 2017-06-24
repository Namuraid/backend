defmodule Namuraid.LiveFeedChannel do
  use Phoenix.Channel

  def join("livefeed", _params, socket) do
    # TODO put token an pageid in the db
    {:ok, %{
      "token" => "",
      "pageId" => ""
    }, socket}
  end
end
