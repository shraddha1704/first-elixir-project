defmodule Firstelixir.Plugins do
  def track(%{status: 404, path: path} = conv) do
    IO.puts "Warning: #{path} is on the loose!"
    conv
  end

  def track(conv) do
    conv
  end

  def rewrite_path(%{ path: "/wildlife"} = conv) do
    %{ conv | path: "/wildthings"}
  end

  def rewrite_path(conv) do
    conv
  end

  def log(conv) do
    IO.inspect conv
  end
end

