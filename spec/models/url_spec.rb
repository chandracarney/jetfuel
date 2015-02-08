require "rails_helper"

RSpec.describe Url, :type => :model do
  it "can produce shortened urls" do
    url = Url.create!(original_url: "www.example.com/really/long/url/here")

    expect(url.slug).to eq(url.id.to_s(36))
  end

  it "can increment clicks by one" do
    url = Url.create!(original_url: "www.example.com")

    url.increase_popularity

    expect(url.popularity).to eq 1
  end
end
