json.extract! story_datum, :id, :story_no, :title, :max_page, :created_at, :updated_at
json.url story_datum_url(story_datum, format: :json)
