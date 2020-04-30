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
  
  has_many :posts
end
