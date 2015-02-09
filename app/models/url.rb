class Url < ActiveRecord::Base
  after_create :generate_slug

  def generate_slug
    self.slug = id.to_s(36)
    save
  end

  def increase_popularity
    self.popularity += 1
    save!
  end

  def self.sorted_by_popularity
    order(popularity: :desc)
  end

  def self.sorted_by_last_created
    all.sort_by { |url| url.created_at }.reverse!
  end

  def pretty_timestamp
    created_at.strftime("Added on %B %e, %Y at %l:%M and %S seconds")
  end
end
