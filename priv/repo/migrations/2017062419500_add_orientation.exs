defmodule Namuraid.Repo.Migrations.AddOrientation do
  use Ecto.Migration

  def change do
    alter table(:sponsor) do
      add :orientation, :string
    end
  end
end

