class AddCardnumToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cardnum, :string
  end
end
