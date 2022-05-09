# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @book = current_user.books.new
    @books = current_user.books.order(created_at: :desc).page(params[:page])
  end

  def show
    @photos = @book.photos.order(created_at: :desc)
  end

  def edit; end

  def create
    @book = current_user.books.new(book_params)
    @books = current_user.books.order(created_at: :desc).page(params[:page])

    if @book.save
      redirect_to books_url, notice: '読み返したい本を登録しました'
    else
      render :index
    end
  end

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
    @book = current_user.books.find(params[:id])
  end
end
