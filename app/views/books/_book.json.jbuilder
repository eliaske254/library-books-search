json.extract! book, :id, :title, :author_id, :publisher_id, :genre_id, :created_at, :updated_at
json.url book_url(book, format: :json)
