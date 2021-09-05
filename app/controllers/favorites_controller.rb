class FavoritesController < ApplicationController
    def create
        @book = Book.find(params[:book_id])
        @favorite = @book.favorites.new(user_id: current_user.id)
        # byebug
        @favorite.save
        # byebug
        # redirect_to request.referer
        # redirect_back(fallback_location: root_path)
    end

    def destroy
        @book = Book.find(params[:book_id])
        @favorite = @book.favorites.find_by(user_id: current_user.id)
        # byebug
        @favorite.destroy
        # redirect_to request.referer
        # redirect_back(fallback_location: root_path)
    end
end
