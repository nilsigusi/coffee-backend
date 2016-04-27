# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
Transaction.create!({
  :balance => 0.0,
  :amount => 0.0,
  :user_id => @user.id,
  :paymethod_id => 3
  })
