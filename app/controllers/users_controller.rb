class UsersController < ApplicationController
    before_action :find_user, only: [:show, :update, :destroy, :stats]

    def index
        @user = User.all
        render :json => @user, include: [:scores,:friends,:pending_friends,:current_friends,:current_follows,:completed_challenges]
    end

    def create
        @user = User.create(user_params)
        token = JWT.encode({ user_id: @user.id }, ENV['HKEY'])
        render :json => { token: token, user: @user.as_json(include: [:scores,:current_friends,:current_follows,:completed_challenges])}, :status => :ok
    end

    def show
        if @user
            render :json => @user, :status => :ok
        else
            render :json => {error: 'User not found'}, status: :not_found
        end
    end

    def update
        @user.update(user_params)
        if @user.persisted?
            render :json => @user, status: :ok
        else
            render :json => { errors: @user.errors }
        end
    end

    def destroy
        # @user.is_active = false
        # if(@user.save())
        #     render :json => { :message => "Succesful." }
        # end
    end

    def staylogged
        find_user_by_username
        render :json => { user: @user.as_json(include: [:scores,:friends,:pending_friends,:current_friends,:current_follows,:completed_challenges])}, :status => :ok
    end

    def stats
        userStats = {}
        userStats[:highest_line_score] = @user.highest_line_score
        userStats[:highest_speed_score] = @user.highest_speed_score
        userStats[:highest_total_score] = @user.highest_total_score

        render :json => userStats, :status => :ok
    end

    private
    def user_params
        params.require(:user).permit(:username, :img, :password)
    end

    def token_params
        params.require(:user).permit(:name)
    end

    def find_user
        @user = User.find_by(id: params[:id])
    end

    def find_user_by_username
        @user = User.find_by(username: params[:username])
    end
end
