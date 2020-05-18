class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  #パスワード
  has_secure_password
  validates :password, presence: true, length: { minimum: 7 }
  #画像アップロード
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  
  has_many :posts, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  has_many :sweets, through: :likes, source: :post
  
  has_many :comments, dependent: :destroy
  
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user

  def sweet(post) 
    likes.find_or_create_by(post_id: post.id) 
  end
  
  def notsweet(post) 
    like = likes.find_by(post_id: post.id)
    like.destroy if like
  end
  
  def like?(post) 
    self.sweets.include?(post)
  end
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
