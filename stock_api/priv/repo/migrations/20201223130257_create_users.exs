defmodule StockApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do

      add :id, :uuid, primary_key: true
      add :full_name, :string
      add :email, :string
      add :password_hash, :string
      add :phone_number, :string
      add :last_time_online, :time

      timestamps()
    end

    create unique_index(:users, [:email])

  end
end
