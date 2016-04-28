class MobilesController < ApplicationController

  before_action :authenticate_jwt
  before_action :set_mobile, only: [:show, :update, :destroy]


  # GET /users/:user_id/cardnums
  # def index
  #   @user = User.where(id: params[:user_id]).last
  #   render json: @user
  # end

  # GET /users/:user_id/cardnums/:id
  # GET cardnums/:id
  # def show
  #   if params[:user_id]
  #     @user = User.where(cardnum: params[:id], id: params[:user_id]).last or not_found
  #     render json: @user
  #   else
  #     @user = User.where(cardnum: params[:id]).last or not_found
  #     render json: @user
  #   end
  # end

  # # PATCH/PUT /users/:user_id/cardnums/:id
  # def update
  #   @user = User.where(id: params[:user_id]).last
  #   if @user.update(cardnum: params[:id])
  #      render json: @user
  #   else
  #      render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  # private
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobile
      @mobile = Mobile.find(params[:id])
    end

    # # Only allow a trusted parameter "white list" through.
    # def message_params
    #   params.require(:message).permit(:title, :user_id)
    # end
end
