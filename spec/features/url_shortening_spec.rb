require "rails_helper"

describe "shortened urls", type: :feature do

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

  context "url redirect" do
    it "redirects to original url" do
      url = Url.create!(original_url: "https://www.example.com/")

      visit urls_path
      find_link("fuel.it/#{url.slug}").click

      expect(current_url).to eq(url.original_url)
    end
  end
end
