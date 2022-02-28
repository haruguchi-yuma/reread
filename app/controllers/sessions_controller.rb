# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    # byebug
    auth_hash = request.env['omniauth.auth']
    user = User.find_or_create_from_auth_hash!(auth_hash)
    session[:user_id] = user.id

    # リフレッシュトークンをキャッシュする　キーは　なんか合体させる
    # Rails.cache.write(auth_hash.uid + α, auth_hash.credentials.token)

    Redis.current.set(auth_hash.uid, auth_hash.credentials.token)
    redirect_to books_path, notice: 'ログインしました'
  end

  def destroy
    reset_session
    # リフレッシュトークンのキャッシュを削除する
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
