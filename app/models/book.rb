class Book < ApplicationRecord
  belongs_to :author
  belongs_to :publisher
  belongs_to :genre

  include PgSearch::Model
  pg_search_scope :pg_search,
                  against: :title,
  using: {
    tsearch: { dictionary: 'english' }
  },
    associated_against: {
      author: :name,
      publisher: :name,
      genre: :name
  }

  def self.search(query)
    return all unless query.present?
   # where(title: query)
   #  where("title ILIKE ?", "%#{query}%")
   #  where("to_tsvector('english', title) @@ plainto_tsquery('english', :q)", q: query)

    # where("title ILIKE ?", "%#{query}%")
    # .joins(:author).or(Book.where("authors.name ILIKE ?", "%#{query}%"))
    # .joins(:publisher).or(Book.where("publishers.name ILIKE ?", "%#{query}%"))
    # .joins(:genre).or(Book.where("genres.name ILIKE ?", "%#{query}%"))
    pg_search(query)
  end
end
