# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  REDIRECT_URI = "http://localhost:3000/oauth2callback".freeze
  # APPLICATION_NAME = "reRead(テスト)".freeze
  TOKEN_PATH = "token.yaml".freeze
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR

  def create
    user = User.find_or_create_from_auth_hash!(request.env['omniauth.auth'])
    session[:user_id] = user.id

    client_id = Google::Auth::ClientId.from_file "credentials.json"
    token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = "primary"
    credentials = authorizer.get_credentials user_id

    if credentials.nil?
      redirect_to authorizer.get_authorization_url(base_url: REDIRECT_URI), notice: 'ログインしました'
    else
      redirect_to books_path, notice: 'ログインしました'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
