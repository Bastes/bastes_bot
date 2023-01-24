defmodule BastesBot.Commands do
  use Alchemy.Cogs

  Cogs.set_parser(:ping, fn message ->
    IO.inspect(message)
    List.wrap(message)
  end)

  Cogs.def ping do
    IO.puts("ping received")
    IO.inspect(message, label: "message")
    Cogs.say("Pong!!!")
  end

  Cogs.def ping(arg) do
    IO.puts("ping received")
    IO.inspect(arg, labal: "arg")
    IO.inspect(message, label: "message")
    Cogs.say("Pong!!! #{arg}")
  end
end
