class PaymethodsController < ApplicationController
  before_action :authenticate_jwt
  before_action :set_paymethod, only: [:show, :update, :destroy]

  # GET /paymethods
  def index
    @paymethods = Paymethod.all

    render json: @paymethods
  end

  # GET /paymethods/1
  def show
    render json: @paymethod
  end

  # POST /paymethods
  def create
    @paymethod = Paymethod.new(paymethod_params)

    if @paymethod.save
      render json: @paymethod, status: :created, location: @paymethod
    else
      render json: @paymethod.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /paymethods/1
  def update
    if @paymethod.update(paymethod_params)
      render json: @paymethod
    else
      render json: @paymethod.errors, status: :unprocessable_entity
    end
  end

  # DELETE /paymethods/1
  def destroy
    @paymethod.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paymethod
      @paymethod = Paymethod.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def paymethod_params
      params.require(:paymethod).permit(:title, :price)
    end
end
