class TransactionsController < ApplicationController

  before_action :authenticate_jwt
  before_action :set_transaction, only: [:show, :update, :destroy]

  # get transactions only possible for user.. so
  # GET users/:user_id/transactions
  def index
    #@transactions = Transaction.all
    if current_user.id.to_i != params[:user_id].to_i
      render :status => :unauthorized
      return
    end

    @transactions = Transaction.order(created_at: :desc).where(user_id: params[:user_id])
    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    if current_user.id.to_i == params[:user_id].to_i || current_user.admin
      # nothing to do - ok
    else
      render :status => :unauthorized
      return
    end

    balance = 0

    begin
      @last = Transaction.order("id").where(user_id: params[:user_id]).last
      logger.debug @last[:balance]

      if !@last.nil?
        balance = @last[:balance]
      end
    rescue
    end

    new_balance = transaction_params[:amount].to_f + balance.to_f
    new_balance = float_of_2_decimal(new_balance)

    @transaction = Transaction.new(transaction_params.merge(balance: new_balance))

    if @transaction.save
      render json: @transaction, status: :created, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.require(:transaction).permit(:amount, :user_id, :paymethod_id, :balance)
    end

    def float_of_2_decimal(float_n)
      float_n.round(4).to_s[0..4].to_f
    end
end
