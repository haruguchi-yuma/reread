require "google/apis/calendar_v3"
require "googleauth"
require "googleauth/stores/file_token_store"
require "date"
require "fileutils"

class ReadHistoriesController < ApplicationController
  REDIRECT_URI = "http://localhost:3000/oauth2callback".freeze
  APPLICATION_NAME = "reRead(テスト)".freeze
  TOKEN_PATH = "credentials.yaml".freeze
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR
  MY_CALENDAR_ID = 'primary'

  def new
    @read_history = Book.find(params[:book_id]).read_histories.new
  end

  def create
    @read_history = Book.find(params[:book_id]).read_histories.new(read_history_params)

    if @read_history.save
      calendar = Google::Apis::CalendarV3::CalendarService.new
      calendar.client_options.application_name = APPLICATION_NAME
      calendar.authorization = authorize
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

  def callback
    session[:code] = params[:code]
    calendar = Google::Apis::CalendarV3::CalendarService.new
    calendar.client_options.application_name = APPLICATION_NAME
    calendar.authorization = authorize
    redirect_to books_path
  end

  def authorize
    client_id = Google::Auth::ClientId.from_file "client_secret.json"
    token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = "primary"
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
      code = session[:code]
      url = authorizer.get_authorization_url(base_url: REDIRECT_URI)
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: REDIRECT_URI
      )
    end
    credentials
  end

  private

  def read_history_params
    params.require(:read_history).permit(:summary, :read_back_at, :description)
  end
end
