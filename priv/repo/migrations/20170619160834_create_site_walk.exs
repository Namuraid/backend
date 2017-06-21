defmodule Namuraid.Repo.Migrations.CreateSiteWalk do
  use Ecto.Migration

  def change do
    create table(:sitewalk) do
      add :x, :integer
      add :y, :integer
      add :w, :integer
      add :h, :integer

      timestamps()
    end

  end
end
