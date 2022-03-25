# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[show edit update destroy]

  def index
    @book = current_user.books.new
  end

  def create
    @book = current_user.books.new(book_params)
    @books = current_user.books.order(created_at: :desc).page(params[:page])

    if @book.save
      redirect_to books_url, notice: '書籍を登録しました'
    else
      render :index
    end
  end

  def show
    @photos = @book.photos.order(created_at: :desc)
  end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "「#{@book.title}」に変更しました "
    else
      render :edit
    end
  end

  def destroy
    @book.destroy!
    redirect_to books_url, notice: "「#{@book.title}」を削除しました"
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def correct_user
    return if current_user == @book.user

    redirect_to books_url
  end
end
