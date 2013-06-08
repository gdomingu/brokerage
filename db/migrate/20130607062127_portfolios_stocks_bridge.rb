class PortfoliosStocksBridge < ActiveRecord::Migration
  def change
    create_table :portfolios_stocks, id: => false do |t|
      t.integer :portfolio_id
      t.integer :stock_id
    end
  end
end
