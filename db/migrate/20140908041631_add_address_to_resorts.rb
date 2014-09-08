class AddAddressToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :address, :string
  end
end
