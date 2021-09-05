class RelationshipsController < ApplicationController
    before_action :set_user
    def create
        folloing = current_user.follow(@user)
        # byebug
        if folloing.save
            flash[:success] = 'フォローしました'
            redirect_to request.referer
        else
            redirect_to request.referer
        end
    end
    def destroy
        following = current_user.unfollow(@user)
        if following.destroy
          flash[:success] = 'ユーザーのフォローを解除しました'
          redirect_to request.referer
        else
          redirect_to request.referer
        end
    end
    
    

    private
  def set_user
    @user = User.find(params[:user_id])
  end

end
