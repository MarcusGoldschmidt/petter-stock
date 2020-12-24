defmodule StockApi.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :full_name, :string

    field :email, :string
    field :email_confirmation, :string, virtual: true

    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    field :phone_number, :string
    field :last_time_online, :time

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :full_name,
      :phone_number,
      :email,
      :email_confirmation,
      :password,
      :password_confirmation
    ])
    |> validate_required([
      :full_name,
      :email,
      :email_confirmation,
      :phone_number,
      :password,
      :password_confirmation
    ])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:email)
    |> validate_confirmation(:email)
    |> validate_confirmation(:password)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
