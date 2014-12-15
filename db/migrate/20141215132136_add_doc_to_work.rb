class AddDocToWork < ActiveRecord::Migration
  def change
    add_column :works, :doc, :string
  end
end
