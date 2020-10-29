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
        render json: params
    end

    def update #put/patch
        # user = User.find_by(id: params[:id])
        user = User.new(user_params)
        
        if user.save
            # user.update(user_params)
            redirect_to user_url(user)
        else
            render json: user.errors.full_message, status:422
        end
    end
    
    
    
    
    private 
    
    def user_params
        params.require(:user).permit(:name, :email)
    end
        
end