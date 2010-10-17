module RankingsHelper
  
  def twitter_image_url(url)
    return image_tag(url) if url.present?
    ''
  end
  
end
