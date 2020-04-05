module FavoriteTweetsHelper
  def render_oembed(tweet)
    begin
      oembed = current_user.twitter_client.oembed(tweet.twitter_id)
      oembed.html.html_safe
    rescue Twitter::Error => e
      "Oh no, there was an error loading that tweet: #{e.message}"
    end
  end
end
