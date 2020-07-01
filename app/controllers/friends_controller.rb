class FriendsController < ApplicationController
    before_action :find_friend, only: [:show, :update, :destroy]

    def index
        @friend = friend.all
        # include the friending spots the friend belongs to
        render :json => @friend, status: :ok
    end

    def create
        @friend = Friend.create(friend_params)
        if @friend.persisted?
            render :json => @friend, status: :created
        else
            render :json => { errors: @friend.errors }
        end
    end

    def show
        if @friend
            render :json => @friend
        else
            render :json => {error: 'friend not found'}, status: :not_found
        end
    end

    def update
        @friend.update(friend_params)
        if @friend.persisted?
            render :json => @friend, status: :ok
        else
            render :json => { errors: @friend.errors }
        end
    end

    def destroy
        @friend.is_active = false
        if(@friend.save())
            render :json => { :message => "Succesful." }
        end
    end

    private
    def friend_params
        params.require(:friend).permit(:requestor_id,:target_id,:accepted)
    end

    def find_friend
        @friend = friend.find_by(id: params[:id])
    end
end
