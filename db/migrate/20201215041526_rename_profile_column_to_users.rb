class RenameProfileColumnToUsers < ActiveRecord::Migration[5.2]
  def change
     rename_column :users, :profile, :introduction
  end
end
