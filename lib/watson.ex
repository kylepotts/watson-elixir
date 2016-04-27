defmodule Watson do
  use Application

  def start(_type, _args) do
    Watson.Supervisor.start_link(WatsonRoutes)
  end

end

defmodule WatsonRoutes do
  def routes do
    [
      {~r/watson status/, {WatsonHello, :status}},
      {~r/watson (who am I|what('s| is) my name)/, {WatsonHello, :who_am_i}}
    ]
  end
end

defmodule WatsonHello do
  def status(message,slack) do
    "Hello From Big Blue"
  end
  def who_am_i(message,slack) do
    user = slack.users[message.user]
    name = user.real_name
    "You are #{name} and your Slack ID is #{message.user}"
  end
end
