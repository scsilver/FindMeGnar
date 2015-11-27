class AddScrapeXpathBaseToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :scrape_xpath_base, :string
  end
end
