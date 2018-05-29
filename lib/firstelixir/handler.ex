defmodule Firstelixir.Handler do
  def handle(request) do
    # conv = parse(request)
    # conv = route(conv)
    # format_response(conv)

    request
    |> parse
    |> route
    |> format_response
  end

  def parse(request) do
    # TODO: Parse the request string into key-value pair/ map
    [method, path, _] = request
    |> String.split("\n")
    |> List.first
    |> String.split(" ")
    %{ mathod: method, path: path, resp_body: ""}
  end

  def route(conv) do
    # TODO: Create a new map that also has the response body
    %{ conv | resp_body: "Bears, Lions, Tigers"}
  end

  def format_response(conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Firstelixir.Handler.handle(request)

IO.puts response
