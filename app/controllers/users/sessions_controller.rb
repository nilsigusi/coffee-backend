require 'rubygems'
require 'net/ldap'

# This is an example of how to extend the devise sessions controller
# to support JSON based authentication and issuing a JWT.
class Users::SessionsController < Devise::SessionsController

  include ActionController::MimeResponds

  # Require our abstraction for encoding/deconding JWT.
  require 'auth_token'

  # Disable CSRF protection
  skip_before_action :verify_authenticity_token

  # Be sure to enable JSON.
  respond_to :html, :json

  # POST /resource/sign_in
  def create
    luser = params[:user][:email]
    lpass = params[:user][:password]

    result = nil
    begin
      ldap = initialize_ldap_con
      result = ldap.bind_as(
          :base => LdapConf.binding['base'],
          :filter => "(#{LdapConf.binding['user_field']}=#{luser})",
          :password => lpass
      )
    rescue
      # error by ldap connection, result=nil then
    end

    if result

      puts result.first.mail
      email = result.first.mail[0]
      @user = User.where(email: email).first

      if(@user.nil?)
        puts "WOULD CREATE A USER"
        @user = User.new(name: "#{result.first["givenName"][0]} #{result.first["sn"][0]}", email: email, password: "21jnfdsf0234jkewrkf034", password_confirmation: "21jnfdsf0234jkewrkf034")
        sign_in @user
        sign_in @user, :bypass => true

        # Create very first transaction with 0-balance
        Transaction.create!({
          :balance => 0.0,
          :amount => 0.0,
          :user_id => @user.id,
          :paymethod_id => 3
          })

        # Generate Mobile table for that user_id
        Mobile.create!({
          :user_id => @user.id,
          :nfc_card_number => nil,
          :mobile_id => luser,
          :mobile_pin => 4.times.map { [*'0'..'9'].sample }.join
          })
      end

      token = AuthToken.issue_token({ user_id: @user.id, user_name: @user.name })
      respond_to do |format|
        format.json { render json: {user: @user.email, token: token} }
      end

    else

      # LDAP was not successfull - so lets try normal way

      # This is the default behavior from devise - view the sessions controller source:
      # https://github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb#L16
      self.resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)
      yield resource if block_given?

      # Here we're deviating from the standard behavior by issuing our JWT
      # to any JS based client.
      token = AuthToken.issue_token({ user_id: resource.id, user_name: resource.name, isadmin: resource.admin })
      respond_to do |format|
        format.json { render json: {user: resource.email, token: token} }
      end

    end

    # The default behavior would have been to simply fire respond_with:
    # respond_with resource, location: after_sign_in_path_for(resource)
  end

  private
  def initialize_ldap_con
    ldap = Net::LDAP.new(
      host: LdapConf.server['host'],    # Thankfully this is a standard name,
      port: LdapConf.server['port'],
      encryption: LdapConf.server['encryption'],
      auth: { :method => :simple, dn: LdapConf.admin['dn'], password: LdapConf.admin['password'] }
    )
  end
end
