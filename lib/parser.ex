defmodule Firstelixir.Parser do

  alias Firstelixir.Conv
  def parse(request) do
    [top, params_string] = String.split(request, "\n\n")
    [request_line | header_line] = String.split(top, "\n")
    [method, path, _] = String.split(request_line, " ")

    params = parseParams(params_string)

    %Conv{
       method: method,
       path: path,
       params: params
      }
  end

  def parseParams(params_string) do
    params_string |> String.trim |> URI.decode_query
  end
end
