defmodule Namuraid.ScreenTest do
  use Namuraid.ModelCase

  alias Namuraid.Screen

  @valid_attrs %{activeScreen: "some content", bgColor: "some content", height: 42, name: "some content", width: 42, x: 42, y: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Screen.changeset(%Screen{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Screen.changeset(%Screen{}, @invalid_attrs)
    refute changeset.valid?
  end
end
