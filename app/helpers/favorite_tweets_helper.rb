module FavoriteTweetsHelper
  def render_oembed(tweet)
    begin
      oembed = current_user.twitter_client.oembed(tweet.twitter_id)
      oembed.html.html_safe
    rescue Twitter::Error::NotFound
      "Ugh, that tweet was deleted. What a bummer."
    end
  end
end
