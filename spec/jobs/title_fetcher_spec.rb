require "rails_helper"

describe TitleFetcher do
  it "can fetch a title from an external site" do
    url = Url.create!(original_url: "https://www.example.com/")
    TitleFetcher.perform(url)

    expect(url.reload.title).to include("Example Domain")
  end
end
