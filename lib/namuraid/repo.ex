defmodule Namuraid.Repo do
  use Ecto.Repo, otp_app: :namuraid
  import Ecto.Query

  def all_screens() do
    query = from s in Namuraid.Screen,
      select: s.name
    Namuraid.Repo.all(query)
  end

  def all_panValues() do
    query = from Namuraid.SiteWalk,
      select: [:x, :y, :w, :h]
    Namuraid.Repo.all(query)
  end
end
