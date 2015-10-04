class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                                      format: { with: VALID_EMAIL_REGEX },
                                      uniqueness: { case_sensitive: false }
    has_secure_password
    has_many :microposts
    
    #フォロー機能
    has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    
    #お気に入り機能
    has_many :favorites, dependent: :destroy
    has_many :favorite_microposts, through: :favorites, source: :micropost

    # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end
  
  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

 # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  #お気に入り表示
  def favorite(micropost)
      favorites.create(micropost_id: micropost.id)
  end
  
  #お気に入り解除
  def unfavorite(micropost)
      favorites.find_by(micropost_id: micropost.id).destroy
  end

  #お気に入りをしているかどうか確認
  def favorite?(micropost)
      favorite_microposts.include?(micropost)
  end
    
  #タイムライン表示
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end

end