class Product < ApplicationRecord
  has_many :cart_products, dependent: :destroy 
  belongs_to :admin
  has_many :purchase_histories
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader 
  
  
end
