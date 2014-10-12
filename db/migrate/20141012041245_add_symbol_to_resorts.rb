class AddSymbolToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :symbol, :string
  end
end
