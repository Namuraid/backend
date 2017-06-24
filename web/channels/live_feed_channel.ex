defmodule Namuraid.LiveFeedChannel do
  use Phoenix.Channel

  def join("sitewalk", _params, socket) do
    {:ok, %{"token" => "images/plan_2017.jpg"}, socket}
  end
end
