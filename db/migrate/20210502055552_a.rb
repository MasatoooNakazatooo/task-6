class A < ActiveRecord::Migration[5.2]
  def change
    rename_column :books, :title, :name
  end
end
