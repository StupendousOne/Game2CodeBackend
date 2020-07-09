class ChallengesController < ApplicationController
    before_action :find_challenge, only: [:show, :update, :destroy]

    def index
        @challenge = Challenge.all
        # include the challengeing spots the challenge belongs to
        render :json => @challenge, include: :scores, status: :ok
    end

    def create
        @challenge = Challenge.create(challenge_params)
        if @challenge.persisted?
            render :json => @challenge, include: :scores, status: :created
        else
            render :json => { errors: @challenge.errors }
        end
    end

    def show
        if @challenge
            render :json => @challenge
        else
            render :json => {error: 'challenge not found'}, status: :not_found
        end
    end

    def update
        @challenge.update(challenge_params)
        if @challenge.persisted?
            render :json => @challenge, status: :ok
        else
            render :json => { errors: @challenge.errors }
        end
    end

    def destroy
        @challenge.is_active = false
        if(@challenge.save())
            render :json => { :message => "Succesful." }
        end
    end

    private
    def challenge_params
        params.require(:challenge).permit(:name,:desc,:answer,:test_info,:line_par,:speed_par)
    end

    def find_challenge
        @challenge = challenge.find_by(id: params[:id])
    end
end
