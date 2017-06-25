defmodule Namuraid.SponsorController do
  use Namuraid.Web, :controller
  require Logger

  alias Namuraid.Sponsor


  def index(conn, %{"seed" => "true"} = params) do
    seed_sponsors()
    _def_index(conn, params)
  end

  def index(conn, %{"clear" => "true"} = params) do
    Repo.delete_all(Sponsor)
    _def_index(conn, params)
  end

  def index(conn, params) do
    _def_index(conn, params)
  end

  defp _def_index(conn, _params) do
    sponsor = Repo.all(Sponsor)
    render(conn, "index.html", sponsor: sponsor)
  end

  defp seed_sponsors() do
    Enum.map(Path.wildcard("priv/static/images/sponsors/*"),
             fn(path) -> Repo.insert(
               %Sponsor{logo: "/images/sponsors/" <> Path.basename(path),
                 orientation: "landscape", background: "#FFFFFF"})
             end)
  end

  def new(conn, _params) do
    changeset = Sponsor.changeset(%Sponsor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sponsor" => sponsor_params}) do
    changeset = Sponsor.changeset(%Sponsor{}, sponsor_params)

    case Repo.insert(changeset) do
      {:ok, _sponsor} ->
        Namuraid.SponsorsChannel.update_sponsors(Repo.all(Sponsor))
        conn
        |> put_flash(:info, "Sponsor created successfully.")
        |> redirect(to: sponsor_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sponsor = Repo.get!(Sponsor, id)
    render(conn, "show.html", sponsor: sponsor)
  end

  def edit(conn, %{"id" => id}) do
    sponsor = Repo.get!(Sponsor, id)
    changeset = Sponsor.changeset(sponsor)
    render(conn, "edit.html", sponsor: sponsor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sponsor" => sponsor_params}) do
    sponsor = Repo.get!(Sponsor, id)
    changeset = Sponsor.changeset(sponsor, sponsor_params)

    case Repo.update(changeset) do
      {:ok, sponsor} ->
        Namuraid.SponsorsChannel.update_sponsors(Repo.all(Sponsor))
        conn
        |> put_flash(:info, "Sponsor updated successfully.")
        |> redirect(to: sponsor_path(conn, :show, sponsor))
      {:error, changeset} ->
        render(conn, "edit.html", sponsor: sponsor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sponsor = Repo.get!(Sponsor, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sponsor)
    Namuraid.SponsorsChannel.update_sponsors(Repo.all(Sponsor))

    conn
    |> put_flash(:info, "Sponsor deleted successfully.")
    |> redirect(to: sponsor_path(conn, :index))
  end
end
