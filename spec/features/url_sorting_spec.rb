require "rails_helper"

describe "url sorting" do

  context "last updated" do
    it "sorts by last updated by default" do
      url1 = Url.create!(original_url: "www.first.example.com")
      sleep(1)
      url2 = Url.create!(original_url: "www.second.example.com/1")
      sleep(1)
      url3 = Url.create!(original_url: "www.third.example.com/2")

      visit root_path

      within("ul:first") do
        expect(page).to have_content(url3.original_url)
        expect(page).not_to have_content(url1.original_url)
        expect(page).not_to have_content(url2.original_url)
      end
    end
  end

  context "popularity" do
    it "increments by one each time the shortened link is visited" do
      url = Url.create!(original_url: "https://www.example.com/")

      visit root_path
      find_link("fuel.it/#{url.slug}").click
      visit root_path

      expect(page).to have_content("Clicks: 1")
      expect(url.reload.popularity).to eq 1
    end

    it "sorts urls by popularity" do
      url1 = Url.create!(original_url: "www.first.example.com", popularity: 4)
      url2 = Url.create!(original_url: "www.second.example.com/1", popularity: 9)
      url3 = Url.create!(original_url: "www.third.example.com/2", popularity: 1)

      visit root_path
      find_link("Sort by Popularity").click

      within("ul:first") do
        expect(page).to have_content(url2.original_url)
        expect(page).not_to have_content(url1.original_url)
        expect(page).not_to have_content(url3.original_url)
      end
    end
  end
end
