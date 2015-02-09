class TitleFetcher
  @queue = :title_fetcher

  def self.perform(url_hash)
    url = Url.find(url_hash["id"])
    url.title = _title(_html_body(url_hash["original_url"]))
    url.save!
  end

  def self._html_body(url)
    Faraday.get(url).body
  end

  def self._title(html_body)
    Nokogiri::HTML(html_body).title
  end
end
