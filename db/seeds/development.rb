def generate_transaction (user)
  Transaction.create!({
    :balance => 0.0,
    :amount => 0.0,
    :user_id => user.id,
    :paymethod_id => 3
    })
end

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


Paymethod.create!({:title  => 'Coffee Big'})
Paymethod.create!({:title  => 'Coffee Small'})
Paymethod.create!({:title  => 'Refill'})

@user = User.create!({
  :name  => 'Admin',
  :email => 'admin@local.host',
  :password => '12345678',
  :password_confirmation => '12345678',
  :admin => true
  })
generate_transaction(@user)
generate_mobile(@user)

@user = User.create!({
  :name  => 'Test One',
  :email => 'd1@d.de',
  :password => '12345678',
  :password_confirmation => '12345678',
  :admin => false
  })
generate_transaction(@user)
generate_mobile(@user)



@user = User.create!({
  :name  => 'Test Two',
  :email => 'd2@d.de',
  :password => '12345678',
  :password_confirmation => '12345678',
  :admin => false
  })
generate_transaction(@user)
generate_mobile(@user)
