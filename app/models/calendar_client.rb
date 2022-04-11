# frozen_string_literal: true

class CalendarClient
  def initialize(user)
    google_client_id = Rails.env.production? ? Rails.application.credentials.google[:client_id] : ENV['GOOGLE_CLIENT_ID']
    google_client_secret = Rails.env.production? ? Rails.application.credentials.google[:client_secret] : ENV['GOOGLE_CLIENT_SECRET']
    @service = Google::Apis::CalendarV3::CalendarService.new
    @user = user
    @client = Signet::OAuth2::Client.new(
      client_id: google_client_id,
      client_secret: google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      access_token: Rails.cache.read(user.uid),
      refresh_token: Rails.cache.read(user.uid + user.id.to_s),
      expires_at: Rails.cache.read("#{user.uid}expires_at")
    )
  end

  def create_event(read_history)
    event = Google::Apis::CalendarV3::Event.new(
      summary: read_history.summary,
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date: read_history.read_back_at
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date: read_history.read_back_at
      ),
      description: read_history.description
    )
    authorize
    @service.insert_event('primary', event)
  end

  private

  def authorize
    refresh!
    @service.authorization = @client
  end

  def refresh!
    return unless @client.expired?

    @client.refresh!
    Rails.cache.write("#{@user.uid}expires_at", @client.expires_at)
    Rails.cache.write(@user.uid, @client.access_token)
  end
end
