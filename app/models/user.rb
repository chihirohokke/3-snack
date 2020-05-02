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
  
  has_many :posts
  
  has_many :likes
  has_many :sweets, dependent: :destroy, through: :likes, source: :post
  
  has_many :comments, dependent: :destroy
  
  
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
end
