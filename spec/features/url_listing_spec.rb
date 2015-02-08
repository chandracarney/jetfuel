require "rails_helper"

describe "url listing page", type: :feature do
  it "lists urls and shortened urls" do
    url1 = Url.create!(original_url: "www.first.example.com")

    url2 = Url.create!(original_url: "www.second.example.com")
    visit root_path

    expect(page).to have_content(url1.original_url)
    expect(page).to have_content("Shortened URL: #{url1.slug}")
    expect(page).to have_content(url2.original_url)
    expect(page).to have_content("Shortened URL: #{url2.slug}")
  end

  context "url form" do
    it "can add a url" do
      visit root_path
      find_link("Add url").click
      long_url = "www.example.com/really/long/example/url"

      fill_in("Original url", with: long_url)
      find_button("Shorten!").click

      expect(current_path).to eq(root_path)
      expect(page).to have_content(long_url)
    end
  end
end
