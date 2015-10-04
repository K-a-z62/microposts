class Changetweet < ActiveRecord::Migration
  def change
    rename_column:favorites,:tweet_id,:micropost_id
  end
end
