defmodule Namuraid.SponsorsChannel do
  use Phoenix.Channel
  alias Namuraid.Sponsor

  def join("sponsors", _params, socket) do
    {:ok, as_sponsors(Namuraid.Repo.all(Sponsor)), socket}
  end

  def update_sponsors(sponsors) do
    Namuraid.Endpoint.broadcast("sponsors", "sponsors", as_sponsors(sponsors))
  end

  defp as_sponsors(values) do
    %{"sponsors" => Enum.map(values, fn(record) -> %{
      "id" => record.id,
      "url" => record.logo,
      "orientation" => record.orientation,
      "background" => record.background
    } end)}
  end
end
