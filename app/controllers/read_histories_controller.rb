# frozen_string_literal: true

class ReadHistoriesController < ApplicationController
  def new
    @read_history = Book.find(params[:book_id]).read_histories.new
  end

  def create
    @read_history = Book.find(params[:book_id]).read_histories.new(read_history_params)

    if @read_history.save
      client = CalendarClient.new(current_user)
      client.create_event(@read_history)

      redirect_to book_path(@read_history.book), notice: '再読日を設定しました'
    else
      render :new
    end
  end

  private

  def read_history_params
    params.require(:read_history).permit(:summary, :read_back_on, :description)
  end
end
