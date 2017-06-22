defmodule Namuraid.Repo.Migrations.CreateSponsor do
  use Ecto.Migration

  def change do
    create table(:sponsor) do
      add :logo, :string

      timestamps()
    end

  end
end
