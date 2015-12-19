class Product < ActiveRecord::Base
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
	
	belongs_to :producer
	has_many :product_categories
	has_many :categories, through: :product_categories

	def cart_action(current_user_id)
	  	if $redis.sismember "cart#{current_user_id}", id
	  		"Remove from"
	  	else
	  		"Add to"
	  	end
 	end

 	def self.search(search)
 		if search
 			where(["name LIKE ?", "%#{search}%"])
 		else
 			all
 		end
 	end
end
