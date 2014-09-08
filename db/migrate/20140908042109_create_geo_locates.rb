class CreateGeoLocates < ActiveRecord::Migration
  def change
    create_table :geo_locates do |t|

      t.timestamps
    end
  end
end
