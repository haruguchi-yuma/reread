# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_logged_in
  helper_method :logged_in?

  private

  def logged_in?
    !!current_user
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  def current_user=(user, auth_hash)
    session[:user_id] = user.id
    user.store_credentials_in_cache(auth_hash)
  end

  def require_logged_in
    return if logged_in?

    redirect_to root_path, alert: 'ログインしてください'
  end
end
