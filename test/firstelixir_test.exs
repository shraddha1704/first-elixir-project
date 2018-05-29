defmodule FirstelixirTest do
  use ExUnit.Case
  doctest Firstelixir

  test "greets the world" do
    assert Firstelixir.hello() == :world
  end
end
