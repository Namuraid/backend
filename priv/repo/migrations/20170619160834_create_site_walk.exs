defmodule Namuraid.Repo.Migrations.CreateSiteWalk do
  use Ecto.Migration

  def change do
    create table(:sitewalk) do
      add :legend, :string
      add :style, :string

      timestamps()
    end

  end
end
