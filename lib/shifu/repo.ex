defmodule Shifu.Repo do
  use Ecto.Repo,
    otp_app: :shifu,
    adapter: Ecto.Adapters.Postgres

  defmacro __using__(_) do
    quote do
      alias Shifu.Repo
      import Ecto
      import Ecto.Query
    end
  end
end
