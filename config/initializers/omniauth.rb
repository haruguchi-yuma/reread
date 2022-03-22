Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'],  ENV['GOOGLE_CLIENT_SECRET'],
    {
      scope: 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/calendar',prompt: 'select_account'
    }

  else
    provider :google_oauth2,
      Rails.application.credentials.google[:client_id],
      Rails.application.credentials.google[:client_secret],
      {
      scope: 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/calendar',prompt: 'select_account'
      }
  end
end
