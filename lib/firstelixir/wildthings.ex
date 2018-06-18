defmodule Firstelixir.Wildthings do

  alias Firstelixir.Bear

  def list_bears do
    [
      %Bear{id: 1, name: "Bear1", type: "Brown", hibernating: true},
      %Bear{id: 2, name: "Bear2", type: "Black"},
      %Bear{id: 3, name: "Bear3", type: "Brown"},
      %Bear{id: 4, name: "Bear4", type: "Grizzly", hibernating: true},
      %Bear{id: 5, name: "Bear5", type: "Brown", hibernating: true},
      %Bear{id: 6, name: "Bear6", type: "Polar"}
    ]
  end

  def get_bear(id) when is_integer(id) do
    Enum.find(list_bears(), fn(b) -> b.id == id end)
  end

  def get_bear(id) when is_binary(id) do
    id |> String.to_integer() |> get_bear()
  end

end
