# app/controllers/users_controller.rb
class UsersController < ApplicationController
    def index #get, shows everything for the user
     #     render plain: "I'm in the index action!"
     render json: User.all
    end

    def show #get Route parameters (e.g. the :id from /users/:id) # user have to specify to see the specific data entry
        render json: User.find_by(id: params[:id])
    end

    def create #post
        # # user = User.find_by(id: params[:id])
        # user = User.new(user_params)
        
        # if user.save
        #     # user.update(user_params)
        #     redirect_to user_url(user)
        # else
        #     render json: user.errors.full_message, status:422
        # end
        # user = User.new(params.require(:user).permit(:name, :email))
        # # replace the `user_attributes_here` with the actual attribute keys
        # user.save!
        # render json: user
        #   .require(:user)
        user = User.new(params.require(:user).permit(:name, :email))
        if user.save
          render json: user
        else
          render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def update #put/patch
        user = User.find(params[:id])
        if user.update_attributes(user_params)
            render json: user
        else
            render json: user.errors, status: :unprocessable_entity
        end
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        render json: user
    end
    
    
    private 
    
    def user_params
        params.require(:user).permit(:name, :email)
    end
        
end