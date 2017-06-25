defmodule Namuraid.TwitterController do
  use Namuraid.Web, :controller

  def create(conn, %{
    "text" => text,
    "user" => %{
      "screen_name" => screen_name
      } = _,
    "created_at" => date
    } = params) do

  end
end
