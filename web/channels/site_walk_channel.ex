defmodule Namuraid.SiteWalkChannel do
  use Phoenix.Channel

  def join("sitewalk", _params, socket) do
    {:ok, %{"picture" => "images/plan_2017.jpg"}, socket}
  end

  def update_panValues(values) do
    Namuraid.Endpoint.broadcast("sitewalk", "panValues", as_pan_values(values))
  end

  def handle_in("refresh", _payload, socket) do
    push socket, "panValues", as_pan_values(Namuraid.Repo.all_panValues())
    {:noreply, socket}
  end

  defp as_pan_values(values) do
    %{"panValues" => Enum.map(values, fn(record) -> %{
      "style" => record.style,
      "legend" => record.legend,
    } end)}
  end
end
