class MobilesController < ApplicationController

  before_action :authenticate_jwt
  before_action :set_mobile, only: [:show, :update, :destroy]

  # Following routes are supported
  #  + GET /users/:user_id/mobiles !no_parameters
  #  + GET /mobiles !parameters: nfc_card_number OR ( mobile_id AND mobile_pin ) + user must be ADMIN
  def index
     if params[:user_id]
       @mobiles = Mobile.where(user_id: params[:user_id]).last or not_found
       render json: @mobiles
     else
       if !current_user.admin
          render :status => :unauthorized
          return
       end

       if params[:nfc_card_number]
         @mobiles = Mobile.where(nfc_card_number: params[:nfc_card_number]).joins(:user).last or not_found
         render json: @mobiles, :include => { :user => {:only => [:name]} }
       elsif params[:mobile_id] && params[:mobile_pin]
         @mobiles = Mobile.where(mobile_id: params[:mobile_id], mobile_pin: params[:mobile_pin]).joins(:user).last or not_found
         render json: @mobiles, :include => { :user => {:only => [:name]} }
       end
     end
  end

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

  # PATCH/PUT /users/:user_id/cardnums/:id
  def update
    if @mobile.update(nfc_card_number: params[:nfc_card_number])
       render json: @mobile
    else
       render json: @mobile.errors, status: :unprocessable_entity
    end
  end

  # private
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobile
      @mobile = Mobile.find(params[:id])
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
    # # Only allow a trusted parameter "white list" through.
    # def message_params
    #   params.require(:message).permit(:title, :user_id)
    # end
end
