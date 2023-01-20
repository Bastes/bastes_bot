defmodule BastesBot.Commands do
  use Alchemy.Cogs

  Cogs.def ping do
    IO.puts("ping received")
    Cogs.say("Pong!!!")
  end
end
