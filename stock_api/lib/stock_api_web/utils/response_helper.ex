defmodule StockApiWeb.ResponseHelper do
  use StockApiWeb, :controller
  alias StockApiWeb.ErrorHelpers

  def ecto_map(result, conn, cb) do
    case result do
      {:ok, data} ->
        cb.(data)

      {:error, data} ->
        errors =
          data.errors
          |> Enum.reduce(%{}, fn {k, v}, acc ->
            Map.put(acc, to_string(k), ErrorHelpers.translate_error(v))
          end)
          |> ProperCase.to_camel_case()

        conn
        |> put_status(400)
        |> json(errors)
    end
  end
end
