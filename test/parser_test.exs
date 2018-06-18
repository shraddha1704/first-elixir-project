defmodule ParserTest do
  use ExUnit.Case
  doctest Firstelixir.Parser

  alias Firstelixir.Parser

  test "parses a list of headers into a map" do
    header_lines = ["A: 1", "B: 2"]

    headers = Parser.parseHeaders(header_lines, %{})

    assert headers = %{"A" => "1", "B" => "2"}
  end
end
