require "rails_helper"

describe "url listing page", type: :feature do
  it "lists urls and shortened urls" do
    url1 = Url.create!(original_url: "www.first.example.com")

    url2 = Url.create!(original_url: "www.second.example.com")
    visit root_path

    expect(page).to have_content(url1.original_url)
    expect(page).to have_content("Shortened URL: fuel.it/#{url1.slug}")
    expect(page).to have_content(url2.original_url)
    expect(page).to have_content("Shortened URL: fuel.it/#{url2.slug}")
  end
end
