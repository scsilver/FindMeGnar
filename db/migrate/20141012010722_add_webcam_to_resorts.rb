class AddWebcamToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :webcam, :string
  end
end
