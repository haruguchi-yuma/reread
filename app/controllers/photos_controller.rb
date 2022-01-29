# frozen_string_literal: true

class PhotosController < ApplicationController
  def index
    @book = Book.find(params[:book_id])
    @photos = @book.photos.order(created_at: :desc)
    @photo = @book.photos.new
  end

  def create
    @photo = Book.find(params[:book_id]).photos.new(photo_params)
    @photos = Book.find(params[:book_id]).photos.order(created_at: :desc)

    if @photo.save
      redirect_to book_photos_path, notice: '写真を投稿しました'
    else
      render :index
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end
end
