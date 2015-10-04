class RemoveMicropostId < ActiveRecord::Migration
  def change
    remove_column :microposts,:micropost_id
  end
end
