defmodule Namuraid.SiteWalkController do
  use Namuraid.Web, :controller

  alias Namuraid.SiteWalk

  def index(conn, _params) do
    sitewalk = Repo.all(SiteWalk)
    render(conn, "index.html", sitewalk: sitewalk)
  end

  def new(conn, _params) do
    changeset = SiteWalk.changeset(%SiteWalk{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"site_walk" => site_walk_params}) do
    changeset = SiteWalk.changeset(%SiteWalk{}, site_walk_params)

    case Repo.insert(changeset) do
      {:ok, _site_walk} ->
        Namuraid.SiteWalkChannel.update_panValues(Repo.all_panValues())
        conn
        |> put_flash(:info, "Site walk created successfully.")
        |> redirect(to: site_walk_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    site_walk = Repo.get!(SiteWalk, id)
    render(conn, "show.html", site_walk: site_walk)
  end

  def edit(conn, %{"id" => id}) do
    site_walk = Repo.get!(SiteWalk, id)
    changeset = SiteWalk.changeset(site_walk)
    render(conn, "edit.html", site_walk: site_walk, changeset: changeset)
  end

  def update(conn, %{"id" => id, "site_walk" => site_walk_params}) do
    site_walk = Repo.get!(SiteWalk, id)
    changeset = SiteWalk.changeset(site_walk, site_walk_params)

    case Repo.update(changeset) do
      {:ok, site_walk} ->
        Namuraid.SiteWalkChannel.update_panValues(Repo.all_panValues())
        conn
        |> put_flash(:info, "Site walk updated successfully.")
        |> redirect(to: site_walk_path(conn, :show, site_walk))
      {:error, changeset} ->
        render(conn, "edit.html", site_walk: site_walk, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    site_walk = Repo.get!(SiteWalk, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(site_walk)

    Namuraid.SiteWalkChannel.update_panValues(Repo.all_panValues())
    conn
    |> put_flash(:info, "Site walk deleted successfully.")
    |> redirect(to: site_walk_path(conn, :index))
  end
end
