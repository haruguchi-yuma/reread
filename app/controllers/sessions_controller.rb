# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    user = User.find_or_create_from_auth_hash!(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to "https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=710323205814-3m0c3d6vl1kdhi7rvo5rpkk9qrkhovo8.apps.googleusercontent.com&redirect_uri=http://localhost:3000/oauth2callback&scope=https://www.googleapis.com/auth/calendar&access_type=offline&approval_prompt=force",
      notice: 'ログインしました'
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
