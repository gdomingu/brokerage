class CreateStocks < ActiveRecord::Migration
 def change
  create_table :stocks do |t|
    t.string :name
    end
  end
end
