class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :image, presence: true
  validates :content, presence: true, length: { maximum: 300 }
  
  #画像アップロード
  mount_uploader :image, ImageUploader
end
