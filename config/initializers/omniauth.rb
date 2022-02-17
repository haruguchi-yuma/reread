Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'],  ENV['GOOGLE_CLIENT_SECRET']
  else
    provider :github,
      Rails.application.credentials.github[:client_id],
      Rails.application.credentials.github[:client_secret]
  end
end
