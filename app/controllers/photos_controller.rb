# frozen_string_literal: true

class PhotosController < ApplicationController
  def new
    @photo = Book.find(params[:book_id]).photos.new
  end

  def create
    @photo = Book.find(params[:book_id]).photos.new(photo_params)
    if @photo.save
      redirect_to book_url(@photo.book), notice: '写真を投稿しました'
    else
      render :new
    end
  end

  private

  def photo_params
    params.fetch(:photo, {}).permit(:image, :note)
  end
end
