defmodule Watson.Commands.Hello do
  @moduledoc """
  Debug
  """

  @doc """
  Matches on ~r/watson status/
  Check the status of Watson, is he alive?
  """
  def status(message,reg_match, slack) do
    "Hello From Big Blue"
  end

  @doc """
  Matches on ~r/watson (who am I|what('s| is) my name)/
  Return your name and your Slack ID
  """
  def who_am_i(message, reg_match, slack) do
    user = slack.users[message.user]
    name = user.real_name
    "You are #{name} and your Slack ID is #{message.user}"
  end
end
