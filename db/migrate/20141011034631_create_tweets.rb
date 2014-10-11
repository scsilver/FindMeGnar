class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :user
      t.string :content
      t.string :time

      t.timestamps
    end
  end
end
