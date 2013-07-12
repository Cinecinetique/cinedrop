json.array!(@sessions) do |session|
  json.extract! session, :new, :create, :destroy
  json.url session_url(session, format: :json)
end