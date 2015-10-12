class Micropost < ActiveRecord::Base
  #つぶやき機能
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }, length: { minimum: 1 }
  
  #お気に入り機能
  has_many :favorites, dependent: :destroy,foreign_key: "micropost_id"
  has_many :favorite_users, through: :favorites ,source: :user
  
  def favorite?(user)
  favorite_users.include?(user)
  end
  
end
