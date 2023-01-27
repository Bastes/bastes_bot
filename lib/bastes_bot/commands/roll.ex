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
    sides = get_option_with_defaults(interaction, "sides", 20)
    number = get_option_with_defaults(interaction, "number", 1)

    {sum, spread} =
      Stream.repeatedly(fn -> Enum.random(0..sides) end)
      |> Stream.take(number)
      |> Enum.reduce({0, []}, fn result, {sum, spread} ->
        {sum + result, [result | spread]}
      end)

    Api.create_interaction_response(interaction, %{
      type: 4,
      data: %{
        content: "*rolled #{number}D#{sides}:*\n**#{sum}**" <> optional_spread(number, spread)
      }
    })
  end

  defp optional_spread(number, spread) do
    if number do
      " " <> inspect(spread, charlists: :as_lists)
    else
      ""
    end
  end

  defp get_option_with_defaults(interaction, option, default) do
    with %{value: value} <- Command.get_option(interaction, option) do
      value
    else
      _ ->
        default
    end
  end
end
