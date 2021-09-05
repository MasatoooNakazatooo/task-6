class BookCommentsController < ApplicationController
    def create
        @book = Book.find(params[:book_id])
        @comment = @book.book_comments.new(comment_params)
        @comment.user_id = current_user.id
        @comment.save
        # redirect_to book_path(@book)
    end

    def destroy
        # byebug
        BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
        @book = Book.find(params[:book_id])
        @comments = @book.book_comments
        # redirect_to book_path(params[:book_id])
    end

    private
    def comment_params
        params.require(:book_comment).permit(:comment)
    end
end
