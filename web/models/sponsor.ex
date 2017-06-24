defmodule Namuraid.Sponsor do
  use Namuraid.Web, :model

  schema "sponsor" do
    field :logo, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:logo])
    |> validate_required([:logo])
  end
end
