# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_or_create_from_auth_hash!(auth_hash)
    session[:user_id] = user.id

    expires_at = auth_hash.credentials.expires_at
    Rails.cache.write('expires_at', expires_at)
    Rails.cache.fetch(user.uid, expires_in: expires_at) do
      auth_hash.credentials.token
    end
    Rails.cache.write(user.uid + user.id.to_s, auth_hash.credentials.refresh_token)
    redirect_to books_path, notice: 'ログインしました'
  end

  def destroy
    Rails.cache.delete(current_user.uid + current_user.id.to_s)
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
