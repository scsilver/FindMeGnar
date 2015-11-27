class AddScrapeXpath24hrToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :scrape_xpath_24hr, :integer
  end
end
