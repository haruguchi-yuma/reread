# frozen_string_literal: true

class Api::BooksController < ApplicationController
  def index
    @books = current_user.books.order(created_at: :desc)
  end
end
