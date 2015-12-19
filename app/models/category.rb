class Category < ActiveRecord::Base
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  	
	has_many :product_categories
	has_many :products, through: :product_categories
end
