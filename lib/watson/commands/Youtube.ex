defmodule Watson.Commands.Youtube do
  @moduledoc """
  Youtube
  """

  @doc """
  Matches on ~r/watson youtube (?<query>.*)/
  Return the video that matches the query on Youtube
  """
  def search_for_youtube_video(message, reg_match, slack) do
    {:ok, videos, _} = Tubex.Video.search_by_query(reg_match["query"])
    video = List.first(videos)
    case video do
      nil -> "No video can be found with query " <> reg_match["query"]
      _   -> create_slack_string(video)
    end
  end

  defp create_slack_string(video) do
    "https://www.youtube.com/watch?v=" <> video.video_id
  end
end
