defmodule BastesBot.Commands.Ping do
  @moduledoc false

  @behaviour BastesBot.Command

  alias Nostrum.Api
  alias BastesBot.Command

  @impl Command
  def spec(name) do
    %{
      name: name,
      description: "A simple health check"
    }
  end

  @impl Command
  def handle_interaction(interaction) do
    Api.create_interaction_response(interaction, %{
      type: 4,
      data: %{content: "Pong!"}
    })
  end
end
