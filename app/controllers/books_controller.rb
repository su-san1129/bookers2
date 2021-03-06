class BooksController < ApplicationController
	before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
  	@books = Book.all.order(created_at: :desc)
  	@book = Book.new

  end

  def new
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
    if @book.save
    	redirect_to book_path(@book.id), notice: "book was successfully created."
    else
      @books = Book.all.order(created_at: :desc)
      render :index
    end
  end

  def show
  	@book = Book.find(params[:id])
    @user = @book.user
    @booknew = Book.new
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  	   redirect_to book_path(@book.id), notice: "book was successfully updated."
    else render :edit
  end
end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path, notice: "Book was successfully destroyed"
  end

private
    def book_params
        params.require(:book).permit(:title, :opinion)
    end
end

def correct_user
    user = Book.find(params[:id]).user
    if current_user != user
      redirect_to users_path
    end
  end
