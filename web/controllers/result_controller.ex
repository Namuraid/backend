defmodule Namuraid.ResultController do
  use Namuraid.Web, :controller
  require Logger

  def index(conn, _params) do
    _render(conn)
  end

  def create(conn, %{"start" => %{"interval" => interval,
        "count" => count,  "from" => from, "running" => running} = _start
      } = _params) do
    Namuraid.State.set(:startinterval, interval)
    Namuraid.State.set(:startcount, count)
    Namuraid.State.set(:startfrom, from)
    Namuraid.State.set(:startrunning, running)
    conn
    |> put_flash(:info, "Updated starting properties!")
    |> redirect(to: start_path(conn, :index))
  end

  defp _render(conn) do
    render(conn, "index.html",
           interval: Namuraid.State.get(:startinterval, "300"),
           count: Namuraid.State.get(:startcount, 30),
           from: Namuraid.State.get(:startfrom, 1),
           running: Namuraid.State. get(:startrunning, false))
  end
end
