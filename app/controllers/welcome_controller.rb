# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :require_logged_in

  def index
    redirect_to books_path if logged_in?
  end

  def tos
    current_user
  end

  def privacy_policy
    current_user
  end
end
