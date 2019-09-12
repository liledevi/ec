json.extract! user, :id, :name, :emai, :password_digest, :image, :created_at, :updated_at
json.url user_url(user, format: :json)
