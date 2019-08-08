defmodule Rumbl.User do
  use Ecto.Schema

  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  alias Rumbl.User

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :videos, Rumbl.Videos.Video

    timestamps()

  end

  # def changeset(%User{} = model, params \\ :empty) do   ## Original code from book - but the :empty does
  #                                                       ## not return an invalid changeset, but rather generates
  #                                                       ## an exception
  def changeset(%User{} = model, params \\ %{}) do
    model
    |> cast(params, ~w(name username)a, [])
    |> validate_length(:username, min: 1, max: 20)
    |> unique_constraint(:username)
  end

  def registration_changeset(%User{} = model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))
      _ ->
        changeset
    end
  end
end
