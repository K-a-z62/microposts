class AddAddressToUser < ActiveRecord::Migration
  def change
    change_column :users, :address, :string
  end
end
