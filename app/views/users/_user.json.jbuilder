json.extract! user, :id, :first, :last, :email, :password_digest, :username, :created_at, :updated_at
json.url user_url(user, format: :json)
