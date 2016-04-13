class BillsController < ApplicationController
  before_action :authenticate_jwt

  # GET /uselist
  def index
    #@transactions = Transaction.all

    if !current_user.admin
      render :status => :unauthorized
      return
    end

    @user = User.select('id', 'name')

    @user.each do |u|
      @transaction = Transaction.where(user_id: u.id).last
      if @transaction.nil?
        break;
      end

      u.balance = @transaction.balance
    end

    render json: @user, methods: [:balance]
  end

end
