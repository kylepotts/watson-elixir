defmodule Watson do
  use Application

  def start(_type, _args) do
    Watson.Supervisor.start_link(WatsonRoutes)
  end

end

defmodule WatsonRoutes do
  def routes do
    [
      {~r/watson status/, {WatsonHello, :status}}
    ]
  end
end

defmodule WatsonHello do
  def status(message,slack) do
    "Hello From Big Blue"
  end
end
