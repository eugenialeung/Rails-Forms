class BooksController < ApplicationController
    def index
        @books = Book.all
        # render json: books
        # render 'index'
        render :index 
    end

    def show
        @book = Book.find_by(id: params[:id])
        # render json: book
        if @book
            render :show
        else
            # return user to index page 
            # redirect_to '/books'
            redirect_to books_url
        end

        # Can also write the above with one line shorter
        # unless @book
        #     redirect_to books_url
        #     return
        # end
        # render :show
    end

    def create
        @book = Book.new(book_params)
        if @book.save
            # show user the book show page
            redirect_to book_url(@book)
        else
            # render json: user.errors.full_messages, status: :unprocessable_e
            # show user the new book form
            render :new
        end
        # render json: "creating book"
    end

    def new
        @book = Book.new
        render :new
    end

    def edit
        @book = Book.find_by(id: params[:id])
        render :edit
    end

    def update
        @book = Book.find_by(id: params[:id])
    
        if @book.update_attributes(book_params)
            redirect_to book_url(@book)
        else
            render :edit
        end
    end

    private
    
    def book_params
        params.require(:book).permit(:title, :author, :year, :category, :description)
    end
end