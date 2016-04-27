defmodule Watson.RTM do
  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_message(message = %{type: "message"}, slack, state) do
    [routes] = state
    reply = Watson.Router.route_message(routes,message.text,slack)
    case reply do
      nil -> nil
      _ -> send_message(reply,message.channel,slack)
    end
    {:ok, state}
  end

  def handle_message(_message, _slack, state) do
    {:ok, state}
  end
end
