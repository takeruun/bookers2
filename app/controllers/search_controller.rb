class SearchController < ApplicationController
  def search
    @search_model = params[:search_model]
    @word = params[:word]

    case @search_model
    when 'Book' then
      @books = Book.search(params)

      render :search
    when 'User' then
      @users = User.search(params)

      render :search
    end
  end
end
