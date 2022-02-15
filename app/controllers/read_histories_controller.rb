require "google/apis/calendar_v3"
require "googleauth"
require "googleauth/stores/file_token_store"
require "date"
require "fileutils"

class ReadHistoriesController < ApplicationController
  def new
    # googleカレンダー認証処理を挟む（フィルター？）
    @read_history = Book.find(params[:book_id]).read_histories.new
  end

  def create
    @read_history = Book.find(params[:book_id]).read_histories.new(read_history_params)

    if @read_history.save
      redirect_to book_path(@read_history.book), notice: '再読日を設定しました'
    else
      render :new
    end
  end

  def read_history_params
    params.require(:read_history).permit(:summary, :read_back_at, :description)
  end
end
