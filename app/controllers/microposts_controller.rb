class MicropostsController < ApplicationController
    before_action :signed_in_user

    def create
        @micropost = current_user.microposts.build(content: params[:micropost][:content])
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_path
        else
            render "static_pages/home"
        end
    end

    def destroy
    end
end
