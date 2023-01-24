defmodule BastesBot.Commands.Roll do
  @moduledoc false

  @behaviour BastesBot.Command

  alias Nostrum.Api
  alias BastesBot.Command

  @impl Command
  def spec(name) do
    %{
      name: name,
      description: "Rolls a Die",
      options: [
        %{
          type: 4,
          name: "number",
          description: "Number of dice to roll",
          required: false
        },
        %{
          type: 4,
          name: "sides",
          description: "Type of dice to roll (number of sides)",
          required: false
        }
      ]
    }
  end

  @impl Command
  def handle_interaction(interaction) do
    %{value: sides} = Command.get_option(interaction, "sides")
    %{value: number} = Command.get_option(interaction, "number")

    {sum, spread} =
      Stream.repeatedly(fn -> Enum.random(0..sides) end)
      |> Stream.take(number)
      |> Enum.reduce({0, []}, fn result, {sum, spread} ->
        {sum + result, [result | spread]}
      end)

    Api.create_interaction_response(interaction, %{
      type: 4,
      data: %{content: "Rolled a #{sum} #{inspect(spread, charlists: :as_lists)}"}
    })
  end
end
