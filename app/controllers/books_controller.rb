# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @book = current_user.books.new
    @books = current_user.books.order(created_at: :desc)
  end

  def create
    @book = current_user.books.new(book_params)
    @books = current_user.books.order(created_at: :desc)

    if @book.save
      redirect_to books_url, notice: '書籍を登録しました'
    else
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @photos = @book.photos.order(created_at: :desc)
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end
end
