defmodule Firstelixir.Handler do

  @moduledoc """
  Handles HTTP request
  """


  @pagesPath Path.expand("../../pages", __DIR__)

  import Firstelixir.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Firstelixir.Parser, only: [parse: 1]

  alias Firstelixir.Conv
  alias Firstelixir.BearController

  @doc """
  Transforms a request into response
  """
  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> format_response
  end

  def route(%Conv{ method: "GET", path: "/wildthings"} = conv) do
    %{ conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{ method: "GET", path: "/bears"} = conv) do
    BearController.index(conv)
  end

  def route(%Conv{ method: "GET", path: "/bears/"<>id} = conv) do
    params = Map.put(conv.params, "id", id)
    BearController.show(conv, params)
  end

  def route(%Conv{ method: "POST", path: "/bears"} = conv) do
    BearController.create(conv, conv.params)
  end

  def route(%Conv{ method: "GET", path: "/about"} = conv) do
    @pagesPath
    |> Path.join("about.html")
    |> File.read
    |> handleFile(conv)
  end

  def route(%Conv{path: path} = conv) do
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

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.fullStatus(conv)}\r
    Content-Type: text/html\r
    Content-Length: #{String.length(conv.resp_body)}\r
    \r
    #{conv.resp_body}
    """
  end

end
