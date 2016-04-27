class MakePinUnique < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :pin, :unique => true
  end
end
