class User < ApplicationRecord
  has_secure_password
  mount_uploader :image, ImageUploader
  has_one :cart, dependent: :destroy
  has_many :purchase_histories
end
