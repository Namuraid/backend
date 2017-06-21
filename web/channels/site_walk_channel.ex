defmodule Namuraid.SiteWalkChannel do
  use Phoenix.Channel

  def join("sitewalk", _params, socket) do
    {:ok, %{"picture" => "images/plan_2017.jpg"}, socket}
  end

  def update_panValues(values) do
    panV = Enum.map(values, fn(record) -> %{
      "width.px" => record.w,
      "height.px" => record.h,
      "margin.left.px" => record.x,
      "margin.top.px" => record.y,
    } end)
    Namuraid.Endpoint.broadcast("sitewalk", "panValues",
                                %{"panvalues" => panV})
  end
end
