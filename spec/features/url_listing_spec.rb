require "rails_helper"

describe "url listing page", type: :feature do
  it "lists urls with all information" do
    url = Url.create!(original_url: "www.example.com",
                       popularity: 1, title: "Example Domain")

    visit root_path

    expect(page).to have_content("Clicks: #{url.popularity}")
    expect(page).to have_content(url.original_url)
    expect(page).to have_content("Shortened URL: fuel.it/#{url.slug}")
    expect(page).to have_content("Title: #{url.title}")
    expect(page).to have_content(url.pretty_timestamp)
  end

  it "gets a title and saves it when a url is added" do
    visit root_path

    find_link("Add url").click
    fill_in("Original url", with: "https://www.example.com/")
    find_button("Shorten!").click

    expect(page).to have_content("Title: Example Domain")
  end
end
