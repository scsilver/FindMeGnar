class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :resort_to
      t.string :location_from
      t.datetime :time_start
      t.datetime :time_end
      t.integer :spots
      t.string :contact_info

      t.timestamps
    end
  end
end
