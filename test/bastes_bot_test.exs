defmodule BastesBotTest do
  use ExUnit.Case
  doctest BastesBot

  test "greets the world" do
    assert BastesBot.hello() == :world
  end
end
