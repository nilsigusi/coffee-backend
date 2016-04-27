class UsersController < ApplicationController

  before_action :authenticate_jwt
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
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
      puts current_user.id
      puts params[:id]
      if current_user.admin || current_user.id.to_i == params[:id].to_i
        @user = User.find(params[:id])
      else
        head :unauthorized
      end
    end

end
