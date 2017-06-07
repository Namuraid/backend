defmodule Namuraid.Repo.Migrations.CreateScreen do
  use Ecto.Migration

  def change do
    create table(:screens) do
      add :name, :string
      add :activeScreen, :string
      add :width, :integer
      add :height, :integer
      add :x, :integer
      add :y, :integer
      add :bgColor, :string

      timestamps()
    end

  end
end
