defmodule BastesBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Alchemy.Client

  defp load_modules() do
    use BastesBot.Commands
  end

  @impl true
  def start(_type, _args) do
    children = []

    Client.start(Application.get_env(:bastes_bot, :token))
    load_modules()

    opts = [strategy: :one_for_one, name: BastesBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
