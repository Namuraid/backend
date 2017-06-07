defmodule Namuraid.ScreenControllerTest do
  use Namuraid.ConnCase

  alias Namuraid.Screen
  @valid_attrs %{activeScreen: "some content", bgColor: "some content", height: 42, name: "some content", width: 42, x: 42, y: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, screen_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing screens"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, screen_path(conn, :new)
    assert html_response(conn, 200) =~ "New screen"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, screen_path(conn, :create), screen: @valid_attrs
    assert redirected_to(conn) == screen_path(conn, :index)
    assert Repo.get_by(Screen, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, screen_path(conn, :create), screen: @invalid_attrs
    assert html_response(conn, 200) =~ "New screen"
  end

  test "shows chosen resource", %{conn: conn} do
    screen = Repo.insert! %Screen{}
    conn = get conn, screen_path(conn, :show, screen)
    assert html_response(conn, 200) =~ "Show screen"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, screen_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    screen = Repo.insert! %Screen{}
    conn = get conn, screen_path(conn, :edit, screen)
    assert html_response(conn, 200) =~ "Edit screen"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    screen = Repo.insert! %Screen{}
    conn = put conn, screen_path(conn, :update, screen), screen: @valid_attrs
    assert redirected_to(conn) == screen_path(conn, :show, screen)
    assert Repo.get_by(Screen, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    screen = Repo.insert! %Screen{}
    conn = put conn, screen_path(conn, :update, screen), screen: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit screen"
  end

  test "deletes chosen resource", %{conn: conn} do
    screen = Repo.insert! %Screen{}
    conn = delete conn, screen_path(conn, :delete, screen)
    assert redirected_to(conn) == screen_path(conn, :index)
    refute Repo.get(Screen, screen.id)
  end
end
