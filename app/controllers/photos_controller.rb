# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show update]

  def new
    @photo = current_user.books.find(params[:book_id]).photos.new
  end

  def create
    @photo = current_user.books.find(params[:book_id]).photos.new(photo_params)
    if @photo.save
      redirect_to book_url(@photo.book), notice: '写真を投稿しました'
    else
      render :new
    end
  end

  def show; end

  def update
    if @photo.update(photo_params)
      redirect_to book_path(@photo.book), notice: 'メモを更新しました'
    else
      render :show
    end
  end

  private

  def photo_params
    params.fetch(:photo, {}).permit(:image, :note)
  end

  def set_photo
    @photo = current_user.books.find(params[:book_id]).photos.find(params[:id])
  end
end
