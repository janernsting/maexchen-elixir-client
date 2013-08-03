defmodule MiaClient do
  def start() do
    incoming = Socket.UDP.open!
    send(incoming, "REGISTER;janernsting")
    run(incoming)
  end

  defp send(incoming, value) do
    Socket.UDP.send!("192.168.252.34", 9000, value, incoming)
  end

  defp run(incoming) do
    msg = recv incoming
    handle incoming, msg
    run incoming
  end

  defp recv(incoming) do
    {msg, _ } = incoming.recv!
    msg
  end

  defp handle(incoming, msg) when is_binary(msg) do
    [op | rest] = String.split msg, ";"
    handle incoming, op, rest
  end

  defp handle(incoming, "ROUND STARTING", rest) do
    IO.puts "Round starting: #{rest}"
    send incoming, "JOIN;#{rest}"
  end

  defp handle(_incoming, op, rest) do
    IO.puts "Unhandled op: #{op} #{inspect rest}"
  end
end

MiaClient.start
