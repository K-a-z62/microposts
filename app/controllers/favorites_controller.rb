class FavoritesController < ApplicationController
before_action :logged_in_user

    def create
        @micropost= Micropost.find(params[:micropost_id])
        current_user.favorite(@micropost)
    end
    
    def destroy
        @favorite= current_user.favorites.find(params[:id])
        binding.pry
        current_user.unfavorite(@favorite)
    end
    

end