class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comments = @book.book_comments
    @new_book = Book.new
    @book_comment = BookComment.new

    @book.page_views.create
  end

  def index
    @books = Book.ranking_by_favorites
    @book = Book.new
  end

  def create
    category = Category.find_by(name: book_params[:category][:name])
    if category.nil?
      category = Category.create(book_params[:category])
    end

    @book = Book.new(book_params.except(:category))
    @book.category_id = category.id
    @book.user_id = current_user.id

    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def order_by
    order_by = params[:order_by]

    @books =
      case order_by
        when "new_date" then
          Book.all.order('created_at desc')
        when "heighest_rate" then
          Book.all.order('rate desc')
        end

    @book = Book.new

    render :index
  end

  def search
    case search_params[:search_type]
    when 'category' then
      @books = Book.joins(:category).where('categories.name = ?', search_params[:word])
    end
    @book = Book.new

    render :index
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate, category: [:name])
  end

  def ensure_correct_user
    user = Book.find(params[:id]).user
    unless user == current_user
      redirect_to user_path(current_user)
    end
  end

  def search_params
    params.fetch(:search, {}).permit(:search_type, :word)
  end
end
