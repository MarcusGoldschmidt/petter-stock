defmodule StockApiWeb.AuthHelper do
  alias StockApiWeb.Guardian

  def authorized?(token) do
    case Guardian.decode_and_verify(token) do
      {:ok, _} ->
        true

      {:error, _} ->
        false
    end
  end

  def get_claims(token) do
    Guardian.decode_and_verify(token)
  end
end
