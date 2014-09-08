class CreateResorts < ActiveRecord::Migration
  def change
    create_table :resorts do |t|
      t.string :name
      t.string :base
      t.string :temp
      t.string :snowfall
      t.string :gnarlocity

      t.timestamps
    end
  end
end
