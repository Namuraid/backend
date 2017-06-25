defmodule Namuraid.StartChannel do
  use Phoenix.Channel

  def join("start", _params, socket) do
    {:ok, %{"interval" => Namuraid.State.get(:startinterval, "300"),
            "count" => Namuraid.State.get(:startcount, 30),
            "from" => Namuraid.State.get(:startfrom, 1),
            "running" => Namuraid.State.get(:startrunning, "false")}, socket}
  end

  def handle_in("getNextStart", _, socket) do
    broadcast! socket, "getNextStart", %{}
    {:noreply, socket}
  end

  def handle_in("nextStart", payload, socket) do
    broadcast! socket, "nextStart", payload
    {:noreply, socket}
  end

  def update(values) do
    Namuraid.Endpoint.broadcast("start", "start", values)
  end
end
