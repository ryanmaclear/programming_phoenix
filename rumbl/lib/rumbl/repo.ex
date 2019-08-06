defmodule Rumbl.Repo do

  @moduledoc """
  A simple in-memory repository
  """

  def all(Rumbl.User) do
    [
      %Rumbl.User{id: "1", name: "Joe", username: "joesoap", password: "password123"},
      %Rumbl.User{id: "2", name: "Fred", username: "fredfunk", password: "secret"},
      %Rumbl.User{id: "3", name: "Bart", username: "bartsimpson", password: "12345"}
    ]
  end
  def all(_module), do: []

  def get(module, id) do
    Enum.find all(module), fn map -> map.id == id end
  end

  def get_by(module, params) do
    Enum.find all(module), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end

  # use Ecto.Repo,
  #   otp_app: :rumbl,
  #   adapter: Ecto.Adapters.Postgres
end
