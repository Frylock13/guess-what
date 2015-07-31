class GamesController < ApplicationController
  def index
    @games = Game.all.order(score: :desc).includes(:user).limit(6)

    respond_to do |format|
      format.json do
        render :json => @games.to_json(:include => { :user => { :only => :name } })
      end
    end
  end

  def create
    @game = current_user.games.new

    respond_to do |format|
      if @game.save
        format.json { render :show, status: :created, location: @game }
      else
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @game = current_user.games.find(params[:id])

    respond_to do |format|
      if @game.update(score: params[:score])
        format.json { render :show, status: :ok, location: @game }
      else
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def start
    if check_exists_key(session[:session_key])
      @current_user = current_user
    else
      redirect_to root_path
    end
  end

  def get_last
    @game = current_user.games.last
  end
end
