defmodule Namuraid.LiveController do
  use Namuraid.Web, :controller

  def index(conn, _params) do
    _render(conn)
  end

  def create(conn, %{"live" => %{
                "token" => token, "pageid" => pageid, "style" => style} = _live} = _params) do
    Namuraid.State.set(:fbtoken, token)
    Namuraid.State.set(:fbpageid, pageid)
    Namuraid.State.set(:fbstyle, style)
    conn
    |> put_flash(:info, "Updated Facebook live properties!")
    |> redirect(to: live_path(conn, :index))
  end

  defp _render(conn) do
    render(conn, "index.html",
           token: Namuraid.State.get(:fbtoken, ""),
           pageid: Namuraid.State.get(:fbpageid, ""),
           style: Namuraid.State.get(:fbstyle, ""))
  end
end
