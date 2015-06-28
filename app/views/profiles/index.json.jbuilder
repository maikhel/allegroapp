json.array!(@profiles) do |profile|
  json.extract! profile, :id, :birthday, :city, :country, :age, :gender, :user_id
  json.url profile_url(profile, format: :json)
end
