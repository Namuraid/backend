defmodule Namuraid.SiteWalk do
  use Namuraid.Web, :model

  schema "sitewalk" do
    field :style, :string
    field :legend, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:style, :legend])
    |> validate_required([:style, :legend])
  end
end
