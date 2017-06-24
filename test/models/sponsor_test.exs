defmodule Namuraid.SponsorTest do
  use Namuraid.ModelCase

  alias Namuraid.Sponsor

  @valid_attrs %{logo: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sponsor.changeset(%Sponsor{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sponsor.changeset(%Sponsor{}, @invalid_attrs)
    refute changeset.valid?
  end
end
