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
      client = CalendarClient.new(current_user)
      client.create_event(@read_history)

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
