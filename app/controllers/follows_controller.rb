class FollowsController < ApplicationController
    before_action :find_follow, only: [:show, :update, :destroy]

    def index
        @follow = Follow.all
        # include the following spots the follow belongs to
        render :json => @follow, status: :ok
    end

    def create
        @follow = Follow.create(follow_params)
        if @follow.persisted?
            render :json => @follow, include: [:target, :follower], status: :created
        else
            render :json => { errors: @follow.errors }
        end
    end

    def show
        if @follow
            render :json => @follow
        else
            render :json => {error: 'follow not found'}, status: :not_found
        end
    end

    def update
        @follow.update(follow_params)
        if @follow.persisted?
            render :json => @follow, status: :ok
        else
            render :json => { errors: @follow.errors }
        end
    end

    def destroy
        @follow.is_active = false
        if(@follow.save())
            render :json => { :message => "Succesful." }
        end
    end

    private
    def follow_params
        params.require(:follow).permit(:follower_id, :target_id)
    end

    def find_follow
        @follow = follow.find_by(id: params[:id])
    end
end
