class AddClientidToPortfolio < ActiveRecord::Migration
  def up
    add_column :portfolios, :client_id, :integer
  end

  def down
    remove_column :portfolios, :client_id
  end
end
