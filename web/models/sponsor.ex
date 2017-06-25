defmodule Namuraid.Sponsor do
  use Namuraid.Web, :model

  schema "sponsor" do
    field :logo, :string
    field :orientation, :string
    field :background, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:logo, :orientation, :background])
    |> validate_required([:logo, :orientation, :background])
  end
end
