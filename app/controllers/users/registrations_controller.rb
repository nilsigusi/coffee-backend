class Users::RegistrationsController < Devise::RegistrationsController
  # Disable CSRF protection
  skip_before_action :verify_authenticity_token

  # Be sure to enable JSON.
  respond_to :html, :json

  before_action :configure_sign_up_params, only: [:create]

# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  #POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    #params.require(:user).permit(:email, :password, :name)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    generate_transaction (resource)
    generate_mobile (resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def generate_mobile (user)
    # 10 attempts to create Mobile entry with unique "mobile_id"
    for i in 0..10
      m_id_1 = "ext"
      m_id_2 = 4.times.map { [*'0'..'9'].sample }.join
      m_id = m_id_1 + m_id_2
      if Mobile.where(:mobile_id => m_id).blank?
        # no sich entry with mobile_id.. ok, lets crate a new one
        Mobile.create!({
          :user_id => user.id,
          :nfc_card_number => nil,
          :mobile_id => m_id,
          :mobile_pin => 4.times.map { [*'0'..'9'].sample }.join
          })
        break;
      else
         # ups, unique entry found.. lets retry
      end
    end
  end

  def generate_transaction (user)
    Transaction.create!({
      :balance => 0.0,
      :amount => 0.0,
      :user_id => user.id,
      :paymethod_id => 3
      })
  end

end
