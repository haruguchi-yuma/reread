# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_logged_in, only: :create

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_or_create_from_auth_hash!(auth_hash)
    session[:user_id] = user.id

    user.store_credentials_in_cache(auth_hash)
    redirect_to books_path, notice: 'ログインしました'
  end

  def destroy
    current_user.delete_refresh_token_in_cache
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
