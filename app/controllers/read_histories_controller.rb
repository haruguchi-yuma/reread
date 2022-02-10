class ReadHistoriesController < ApplicationController
  def new
    # googleカレンダー認証処理を挟む（フィルター？）
    @read_history = Book.find(params[:book_id]).read_histories.new
  end
end
