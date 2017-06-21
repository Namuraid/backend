defmodule Namuraid.SiteWalk do
  use Namuraid.Web, :model

  schema "sitewalk" do
    field :x, :integer
    field :y, :integer
    field :w, :integer
    field :h, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:x, :y, :w, :h])
    |> validate_required([:x, :y, :w, :h])
  end
end
