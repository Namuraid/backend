defmodule Namuraid.ResultChannel do
  use Phoenix.Channel

  def join("result", _params, socket) do
    {:ok, %{
      "result" => Namuraid.State.get(:resultcsv, [])
    }, socket}
  end

  def update(csv) do
    Namuraid.Endpoint.broadcast("result", "result", %{"result" => csv})
  end
end
