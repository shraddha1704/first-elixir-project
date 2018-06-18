defmodule Firstelixir.Parser do

  alias Firstelixir.Conv
  def parse(request) do
    [top, params_string] = String.split(request, "\r\n\r\n")
    [request_line | header_lines] = String.split(top, "\r\n")
    [method, path, _] = String.split(request_line, " ")

    headers = parseHeaders(header_lines, %{})

    params = parseParams(headers["Content-Type"], params_string)

    %Conv{
       method: method,
       path: path,
       params: params,
       headers: headers
      }
  end

  def parseParams("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim |> URI.decode_query
  end

  def parseParams(_,_) do
    %{}
  end

  def parseHeaders([head | tail], headers) do
    [key, value] = String.split(head, ": ")
    headers = Map.put(headers, key, value)
    parseHeaders(tail, headers)
  end

  def parseHeaders([], headers) do
    headers
  end
end
