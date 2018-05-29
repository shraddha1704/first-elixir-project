defmodule Firstelixir.Handler do

  @moduledoc """
  Handles HTTP request
  """

  @doc """
  Transforms a request into response
  """

  @pagesPath Path.expand("../../pages", __DIR__)

  import Firstelixir.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Firstelixir.Parser, only: [parse: 1]

  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> format_response
  end

  def route(%{ method: "GET", path: "/wildthings"} = conv) do
    %{ conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%{ method: "GET", path: "/bears"} = conv) do
    %{ conv | status: 200, resp_body: "Bear1, Bear2, Bear3"}
  end

  def route(%{ method: "GET", path: "/bears/"<>id} = conv) do
    %{ conv | status: 200, resp_body: "Bear #{id}"}
  end

  def route(%{ method: "GET", path: "/about"} = conv) do
    @pagesPath
    |> Path.join("about.html")
    |> File.read
    |> handleFile(conv)
  end

  def route(%{path: path} = conv) do
    %{ conv | status: 404, resp_body: "No #{path} here!" }
  end

  def handleFile({:ok, content}, conv) do
    %{ conv | status: 200, resp_body: content}
  end

  def handleFile({:error, :enoent}, conv) do
    %{ conv | status: 404, resp_body: "File not found"}
  end

  def handleFile({:error, reason}, conv) do
    %{ conv | status: 500, resp_body: "File error: #{reason}"}
  end

  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
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

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Firstelixir.Handler.handle(request)
IO.puts response

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Firstelixir.Handler.handle(request)
IO.puts response


request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Firstelixir.Handler.handle(request)
IO.puts response


request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Firstelixir.Handler.handle(request)
IO.puts response


request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Firstelixir.Handler.handle(request)
IO.puts response
