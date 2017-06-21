defmodule Namuraid.SiteWalkControllerTest do
  use Namuraid.ConnCase

  alias Namuraid.SiteWalk
  @valid_attrs %{h: 42, w: 42, x: 42, y: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, site_walk_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing sitewalk"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, site_walk_path(conn, :new)
    assert html_response(conn, 200) =~ "New site walk"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, site_walk_path(conn, :create), site_walk: @valid_attrs
    assert redirected_to(conn) == site_walk_path(conn, :index)
    assert Repo.get_by(SiteWalk, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, site_walk_path(conn, :create), site_walk: @invalid_attrs
    assert html_response(conn, 200) =~ "New site walk"
  end

  test "shows chosen resource", %{conn: conn} do
    site_walk = Repo.insert! %SiteWalk{}
    conn = get conn, site_walk_path(conn, :show, site_walk)
    assert html_response(conn, 200) =~ "Show site walk"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, site_walk_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    site_walk = Repo.insert! %SiteWalk{}
    conn = get conn, site_walk_path(conn, :edit, site_walk)
    assert html_response(conn, 200) =~ "Edit site walk"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    site_walk = Repo.insert! %SiteWalk{}
    conn = put conn, site_walk_path(conn, :update, site_walk), site_walk: @valid_attrs
    assert redirected_to(conn) == site_walk_path(conn, :show, site_walk)
    assert Repo.get_by(SiteWalk, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    site_walk = Repo.insert! %SiteWalk{}
    conn = put conn, site_walk_path(conn, :update, site_walk), site_walk: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit site walk"
  end

  test "deletes chosen resource", %{conn: conn} do
    site_walk = Repo.insert! %SiteWalk{}
    conn = delete conn, site_walk_path(conn, :delete, site_walk)
    assert redirected_to(conn) == site_walk_path(conn, :index)
    refute Repo.get(SiteWalk, site_walk.id)
  end
end
