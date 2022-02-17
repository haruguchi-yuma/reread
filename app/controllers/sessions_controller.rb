# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    user = User.find_or_create_from_auth_hash!(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to books_path,
      notice: 'ログインしました'
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end
end

# 権限を確認するためには下記URLにアクセスする。
# "https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=668327910696-d7fev31k9qksdi4id9tm3q95g2lis0af.apps.googleusercontent.com&redirect_uri=http://localhost:3000/oauth2callback&scope=https://www.googleapis.com/auth/calendar&access_type=offline&approval_prompt=force"
