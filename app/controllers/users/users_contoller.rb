class UsersController < ApplicationController

  before_action :authenticate_jwt
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /cups
  def index
    if current_user.admin
      @users = User.all
    else
      @users = User.find(current_user.id)
    end
    render json: @users
    #render json: current_user
  end

  def show
    render json: @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if current_user.admin || current_user.id == params[:id]
        @user = User.find(params[:id])
      else
        head :unauthorized
      end
    end

end
