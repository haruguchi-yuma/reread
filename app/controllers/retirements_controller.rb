# frozen_string_literal: true

class RetirementsController < ApplicationController
  def new; end

  def create
    current_user.destroy!
    reset_session
    redirect_to root_path, notice: 'アカウントを削除しました'
  rescue ActiveRecord::RecordNotDestroyed
    redirect_to books_path notice: 'アカウントの削除に失敗しました'
  end
end
