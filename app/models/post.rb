class Post < ApplicationRecord
  belongs_to :user
  
  has_many :likes
  has_many :users, dependent: :destroy, through: :likes
  
  has_many :comments, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :image, presence: true
  validates :content, presence: true, length: { maximum: 300 }
  
  #画像アップロード
  mount_uploader :image, ImageUploader
end
