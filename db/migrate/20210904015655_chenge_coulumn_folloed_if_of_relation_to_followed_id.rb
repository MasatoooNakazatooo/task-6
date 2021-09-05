class ChengeCoulumnFolloedIfOfRelationToFollowedId < ActiveRecord::Migration[5.2]
  def change
    rename_column :relationships, :follewd_id, :followed_id
  end
end
