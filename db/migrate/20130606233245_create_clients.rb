class CreateClients < ActiveRecord::Migration
  def up
    create_table :clients do |t|
      t.string :name
    end
  end

  def down
    drop_table :clients
  end
end
