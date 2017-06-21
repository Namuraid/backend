defmodule Namuraid.ScreenChannel do
  use Phoenix.Channel
  require Logger

  def join("screen:all", _params, socket) do
    {:ok, %{"screens" => Namuraid.Repo.all_screens()}, socket}
  end

  def join("screen:" <> id, _params, socket) do
    case Namuraid.Repo.get_by(Namuraid.Screen, name: id) do
      nil -> {:error, %{reason: "No such screen named <#{id}>!"}}
      screen -> {:ok, init_screen_values(screen), socket}
    end
  end

  defp init_screen_values(screen) do
    %{
      "activeScreen" => screen.activeScreen,
      "width.px" => screen.width,
      "height.px" => screen.height,
      "top" => screen.y,
      "left" => screen.x,
      "background" => screen.bgColor
    }
  end

  def update_activeScreen(screen) do
    Logger.info("Broadcasting active screen change")
    Namuraid.Endpoint.broadcast("screen:#{screen.name}", "activescreen", %{
      "activeScreen" => screen.activeScreen})
  end

  def update_dimension(screen) do
    Namuraid.Endpoint.broadcast("screen:#{screen.name}", "dimension", %{
      "width.px" => screen.width,
      "height.px" => screen.height,
      "top" => screen.y,
      "left" => screen.x,
      "background" => screen.bgColor})
  end

  def update_screen_name_list(names) do
    Namuraid.Endpoint.broadcast("screen:all", "update", %{"screens" => names})
  end
end
