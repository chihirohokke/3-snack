class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  # 画像の上限
  process :resize_to_limit => [700, 700]
 
  # 保存形式をJPGにする
  # process :convert => 'jpg'
 

  #プロフィール詳細画像で使用
  version :thumb do
    process :resize_to_fit => [300, 300]
  end
  #ユーザー一覧&投稿詳細のユーザー画像で使用
  version :thumb100 do
    process :resize_to_fit => [100, 100]
  end
  #投稿一覧のユーザー画像、コメント画像で使用
  version :thumb50 do
    process :resize_to_fit => [50, 50]
  end
  #投稿一覧用
  version :thumb2 do
    process :resize_to_fill => [318, 180]
  end
  #投稿詳細用
  version :thumb3 do
    process :resize_to_fill => [636, 360]
  end
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  # #   # For Rails 3.1+ asset pipeline compatibility:
  #   ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))

  # #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  # process :resize_to_limit => [300, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
    # process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  
  
  # 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  # def filename
  #   super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  # end
 
 # ファイル名を日付にするとタイミングのせいでサムネイル名がずれる
 #ファイル名はランダムで一意になる
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end
 
  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
