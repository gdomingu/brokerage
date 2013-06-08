class CreatePortfolios < ActiveRecord::Migration
    def up
      create_table :portfolios do |t|
        t.string :name
      end
    end

    def down
      drop_table :portfolios
    end
  end