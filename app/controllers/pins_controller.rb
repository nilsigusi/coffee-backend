class PinsController < ApplicationController

  before_action :authenticate_jwt
  # before_action :set_card, only: [:show, :update, :destroy]

  # GET /users/:user_id/cardnums
  def index
    @user = User.where(id: params[:user_id]).last
    render json: @user
  end

  # GET /users/:user_id/pins/:id
  # GET pins/:id
  def show
    if params[:user_id]
      @user = User.where(pin: params[:id], id: params[:user_id]).last or not_found
      render json: @user
    else
      @user = User.where(pin: params[:id]).last or not_found
      render json: @user
    end
  end

  # PATCH/PUT /users/:user_id/pins/:id
  def update
    @user = User.where(id: params[:user_id]).last
    if @user.update(pin: params[:id])
       render json: @user
    else
       render json: @user.errors, status: :unprocessable_entity
    end
  end

  # private
  # # Use callbacks to share common setup or constraints between actions.
  #  def set_card
  #   @cardnum = User.find(params[:user_id])
  #  end
  private
    def not_found
     raise ActionController::RoutingError.new('Not Found')
    end
end
