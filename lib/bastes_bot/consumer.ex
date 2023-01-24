defmodule BastesBot.Consumer do
  @moduledoc false
  use Nostrum.Consumer

  alias BastesBot.Commands
  alias Nostrum.Api

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:READY, _data, _ws_state}) do
    Commands.register_commands()
  end

  def handle_event({:INTERACTION_CREATE, interaction, _ws_state}) do
    Commands.handle_interaction(interaction)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    if !msg.author.bot && String.match?(msg.content, ~r/ping/i) do
      Api.create_message(
        msg.channel_id,
        "Aha, you thought you could stealth-ping me, didn't you? Pong!!"
      )
    else
      :ok
    end
  end

  def handle_event(_data) do
    :ok
  end
end
