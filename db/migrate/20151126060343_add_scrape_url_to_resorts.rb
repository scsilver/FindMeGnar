class AddScrapeUrlToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :scrape_url, :string
  end
end
