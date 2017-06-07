defmodule Namuraid.Screen do
  use Namuraid.Web, :model

  schema "screens" do
    field :name, :string
    field :activeScreen, :string
    field :width, :integer
    field :height, :integer
    field :x, :integer
    field :y, :integer
    field :bgColor, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :activeScreen, :width, :height, :x, :y, :bgColor])
    |> validate_required([:name, :activeScreen, :width, :height, :x, :y, :bgColor])
  end
end
