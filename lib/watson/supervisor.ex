defmodule Watson.Supervisor do
  use Supervisor

  def start_link(routes) do
    Supervisor.start_link(__MODULE__, routes)
  end

  def init(routes) do
    children = [
      worker(Watson.RTM, [Application.get_env(:watson, :api_key),[routes] ])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
