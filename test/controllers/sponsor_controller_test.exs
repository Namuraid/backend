defmodule Namuraid.SponsorControllerTest do
  use Namuraid.ConnCase

  alias Namuraid.Sponsor
  @valid_attrs %{logo: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sponsor_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing sponsor"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, sponsor_path(conn, :new)
    assert html_response(conn, 200) =~ "New sponsor"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, sponsor_path(conn, :create), sponsor: @valid_attrs
    assert redirected_to(conn) == sponsor_path(conn, :index)
    assert Repo.get_by(Sponsor, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sponsor_path(conn, :create), sponsor: @invalid_attrs
    assert html_response(conn, 200) =~ "New sponsor"
  end

  test "shows chosen resource", %{conn: conn} do
    sponsor = Repo.insert! %Sponsor{}
    conn = get conn, sponsor_path(conn, :show, sponsor)
    assert html_response(conn, 200) =~ "Show sponsor"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, sponsor_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    sponsor = Repo.insert! %Sponsor{}
    conn = get conn, sponsor_path(conn, :edit, sponsor)
    assert html_response(conn, 200) =~ "Edit sponsor"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    sponsor = Repo.insert! %Sponsor{}
    conn = put conn, sponsor_path(conn, :update, sponsor), sponsor: @valid_attrs
    assert redirected_to(conn) == sponsor_path(conn, :show, sponsor)
    assert Repo.get_by(Sponsor, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sponsor = Repo.insert! %Sponsor{}
    conn = put conn, sponsor_path(conn, :update, sponsor), sponsor: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit sponsor"
  end

  test "deletes chosen resource", %{conn: conn} do
    sponsor = Repo.insert! %Sponsor{}
    conn = delete conn, sponsor_path(conn, :delete, sponsor)
    assert redirected_to(conn) == sponsor_path(conn, :index)
    refute Repo.get(Sponsor, sponsor.id)
  end
end
