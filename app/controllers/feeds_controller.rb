class feedController < ApplicationController
    before_action :find_feed, only: [:show, :update, :destroy]

    def index
        @feed = feed.all
        # include the feeding spots the feed belongs to
        render :json => @feed, status: :ok
    end

    def create
        @feed = Feed.create(feed_params)
        if @feed.persisted?
            render :json => @feed, status: :created
        else
            render :json => { errors: @feed.errors }
        end
    end

    def show
        if @feed
            render :json => @feed
        else
            render :json => {error: 'feed not found'}, status: :not_found
        end
    end

    def update
        @feed.update(feed_params)
        if @feed.persisted?
            render :json => @feed, status: :ok
        else
            render :json => { errors: @feed.errors }
        end
    end

    def destroy
        @feed.is_active = false
        if(@feed.save())
            render :json => { :message => "Succesful." }
        end
    end

    private
    def feed_params
        params.require(:feed).permit(:feed_text)
    end

    def find_feed
        @feed = feed.find_by(id: params[:id])
    end
end
