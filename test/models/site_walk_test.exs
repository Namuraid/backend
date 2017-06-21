defmodule Namuraid.SiteWalkTest do
  use Namuraid.ModelCase

  alias Namuraid.SiteWalk

  @valid_attrs %{h: 42, w: 42, x: 42, y: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SiteWalk.changeset(%SiteWalk{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SiteWalk.changeset(%SiteWalk{}, @invalid_attrs)
    refute changeset.valid?
  end
end
