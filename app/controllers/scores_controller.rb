class ScoresController < ApplicationController
    before_action :find_score, only: [:show, :update, :destroy]

    def index
        @score = score.all
        # include the scoreing spots the score belongs to
        render :json => @score, include: [:user,:challenge], status: :ok
    end

    def create
        @score = Score.create(score_params)
        if @score.persisted?
            render :json => @score, include: [:user,:challenge], status: :created
        else
            render :json => { errors: @score.errors }
        end
    end

    def show
        if @score
            render :json => @score
        else
            render :json => {error: 'score not found'}, status: :not_found
        end
    end

    def update
        @score.update(score_params)
        if @score.persisted?
            render :json => @score, status: :ok
        else
            render :json => { errors: @score.errors }
        end
    end

    def destroy
        @score.is_active = false
        if(@score.save())
            render :json => { :message => "Succesful." }
        end
    end

    private
    def score_params
        params.require(:score).permit(:line_score,:speed_score,:user_id,:challenge_id, :completed)
    end

    def find_score
        @score = score.find_by(id: params[:id])
    end

end
