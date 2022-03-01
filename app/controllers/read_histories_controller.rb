# require "google/apis/calendar_v3"
# require "googleauth"
# require "googleauth/stores/file_token_store"
# require "date"
# require "fileutils"

class ReadHistoriesController < ApplicationController
  # REDIRECT_URI = "http://localhost:3000/oauth2callback".freeze
  # APPLICATION_NAME = "reRead(テスト)".freeze
  # TOKEN_PATH = "token.yaml".freeze
  # SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR

  def new
    @read_history = Book.find(params[:book_id]).read_histories.new
  end

  def create
    @read_history = Book.find(params[:book_id]).read_histories.new(read_history_params)

    if @read_history.save
      client = Signet::OAuth2::Client.new(
        client_id: ENV['GOOGLE_CLIENT_ID'],
        client_secret: ENV['GOOGLE_CLIENT_SECRET'],
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        access_token: Rails.cache.read(current_user.uid),
        refresh_token: Rails.cache.read(current_user.uid + @current_user.id.to_s),
        expires_at: Rails.cache.read('expires_at')
      )
      if client.expired?
        client.refresh!
        Rails.cache.fetch(current_user.uid, expires_in: client.expires_at) do
          client.access_token
        end
      end
      calendar = Google::Apis::CalendarV3::CalendarService.new
      calendar.authorization = client
      create_event(calendar, @read_history)
      redirect_to book_path(@read_history.book), notice: '再読日を設定しました'
    else
      render :new
    end
  end

  def create_event(service, read_history)
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
    service.insert_event('primary', event)
  end

  private

  def read_history_params
    params.require(:read_history).permit(:summary, :read_back_at, :description)
  end
end
