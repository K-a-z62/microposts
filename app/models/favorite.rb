class Favorite < ActiveRecord::Base
    belongs_to :user,foreign_key: "user_id"
    belongs_to :micropost,foreign_key: "micropost_id"
  
end
