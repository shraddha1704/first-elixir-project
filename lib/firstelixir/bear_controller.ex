defmodule Firstelixir.BearController do

  alias Firstelixir.Wildthings
  alias Firstelixir.Bear

  defp bear_items(bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end

  def index(conv) do
    items =
      Wildthings.list_bears()
      |> Enum.filter(&Bear.is_brown/1)
      |> Enum.sort(&Bear.order_asc_by_name/2)
      |> Enum.map(&bear_items/1)
      |> Enum.join()

    %{ conv | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    %{ conv | status: 200, resp_body: "<h1>Bear #{bear.id}: #{bear.name}</h1>"}
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{ conv | status: 201,
              resp_body: "Created a #{type} bear named #{name}!"}
  end

end
