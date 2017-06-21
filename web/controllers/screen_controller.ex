defmodule Namuraid.ScreenController do
  use Namuraid.Web, :controller
  import Ecto.Changeset
  require Logger

  alias Namuraid.Screen

  def index(conn, _params) do
    screens = Repo.all(Screen)
    render(conn, "index.html", screens: screens)
  end

  def new(conn, _params) do
    changeset = Screen.changeset(%Screen{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"screen" => screen_params}) do
    changeset = Screen.changeset(%Screen{}, screen_params)

    case Repo.insert(changeset) do
      {:ok, _screen} ->
        Namuraid.ScreenChannel.update_screen_name_list(Repo.all_screens())
        conn
        |> put_flash(:info, "Screen created successfully.")
        |> redirect(to: screen_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    screen = Repo.get!(Screen, id)
    render(conn, "show.html", screen: screen)
  end

  def edit(conn, %{"id" => id}) do
    screen = Repo.get!(Screen, id)
    changeset = Screen.changeset(screen)
    render(conn, "edit.html", screen: screen, changeset: changeset)
  end

  def update(conn, %{"id" => id, "screen" => screen_params}) do
    screen = Repo.get!(Screen, id)
    changeset = Screen.changeset(screen, screen_params)
    case Repo.update(changeset) do
      {:ok, screen} ->
        Namuraid.ScreenChannel.update_dimension(screen)
        if get_change(changeset, :name) do
          Namuraid.ScreenChannel.update_screen_name_list(Repo.all_screens())
        end
        conn
        |> put_flash(:info, "Screen updated successfully.")
        |> redirect(to: screen_path(conn, :show, screen))
      {:error, changeset} ->
        render(conn, "edit.html", screen: screen, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    screen = Repo.get!(Screen, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(screen)

    Namuraid.ScreenChannel.update_screen_name_list(Repo.all_screens())
    conn
    |> put_flash(:info, "Screen deleted successfully.")
    |> redirect(to: screen_path(conn, :index))
  end
end
