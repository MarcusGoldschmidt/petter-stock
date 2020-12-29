defmodule StockApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do

      add :id, :uuid, primary_key: true
      add :full_name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :phone_number, :string, null: false
      add :last_time_online, :time

      timestamps()
    end

    create unique_index(:users, [:email])

  end
end
