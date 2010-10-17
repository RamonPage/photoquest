module ApplicationHelper
  def challenge_url(quest)
    %{#{request.protocol+request.host_with_port}/c/#{quest}}
  end
end
