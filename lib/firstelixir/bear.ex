defmodule Firstelixir.Bear do
  defstruct id: nil, name: "", type: "", hibernating: false

  def is_brown(bear) do
    bear.type == "Brown"
  end

  def order_asc_by_name(b1, b2) do
    b1.name <= b2.name
  end
end
