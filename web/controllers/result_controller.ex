defmodule Namuraid.ResultsController do
  use Namuraid.Web, :controller
  require Logger

  def index(conn, _params) do
    _render(conn)
  end

  def create(conn, %{"result" => %{"file" => uploadedFile} = _result
      } = _params) do
    csv = uploadedFile.path
    |> File.stream!()
    |> CSV.decode(separator: ?;)
    |> Enum.filter(fn(row) ->
      case row do
        {:ok, r} -> true
        {:error, msg} -> false
        end
      end)
    |> Enum.slice(5..100000) # TODO: retreive offset from form to keep only good arrived result
    |> Enum.map(
      fn(row) ->
        Logger.info("row is #{inspect(row)}")
        case row do
          {:ok, r} -> %{
            rank: Enum.at(r, 2),
            rankCat: Enum.at(r, 10),
            name: Enum.at(r, 5),
            cat: Enum.at(r, 11),
            time: Enum.at(r, 8)
            }
        end
      end
    )
    Namuraid.State.set(:resultcsv, csv)
    Namuraid.ResultChannel.update(csv)
    conn
    |> put_flash(:info, "Updated result properties!")
    |> redirect(to: results_path(conn, :index))
  end

  defp _render(conn) do
    render(conn, "index.html",
           csv: Namuraid.State.get(:resultcsv, []))
  end
end
