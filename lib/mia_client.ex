defmodule MiaClient do
  def start() do
    incoming = Socket.UDP.open!
    send_msg(incoming, "REGISTER;janernsting")
    run(incoming)
  end

  defp send_msg(incoming, value) do
    Socket.Datagram.send(incoming, value, { "127.0.0.1", 9000 })
  end

  defp run(incoming) do
    msg = recv_msg incoming
    handle incoming, msg
    run incoming
  end

  defp recv_msg(incoming) do
    { :ok, { msg, _ } } = Socket.Datagram.recv incoming
    msg
  end

  defp handle(incoming, msg) when is_binary(msg) do
    [op | rest] = String.split msg, ";"
    handle incoming, op, rest
  end

  defp handle(incoming, "ROUND STARTING", rest) do
    IO.puts "Round starting: #{rest}"
    send_msg incoming, "JOIN;#{rest}"
  end

  defp handle(incoming, "YOUR TURN", [token]) do
    IO.puts "My turn: #{token}"
    send_msg incoming, "ROLL;#{token}"
  end

  defp handle(incoming, "ROLLED", [dice | [ token | _]]) do
    send_msg incoming, "ANNOUNCE;#{dice};#{token}"
  end

  defp handle(_incoming, op, rest) do
    IO.puts "Unhandled op: #{op} #{inspect rest}"
  end
end

MiaClient.start
