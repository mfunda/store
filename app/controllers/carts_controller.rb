class CartsController < ApplicationController
	before_action :authenticate_user!

  def show
  	cart_ids = $redis.smembers current_user_cart
  	@cart_products = Product.find(cart_ids)
    @total = 0
    @cart_products.each do |cp|
      if cp.price != nil
        @total+=cp.price
      end
    end
  end

  def add
  	$redis.sadd current_user_cart, params[:product_id]
  	render json: current_user.cart_count, status: 200
  end

  def remove
  	$redis.srem current_user_cart, params[:product_id]
  	render json: current_user.cart_count, status: 200
  end

  private

  def current_user_cart
  	"cart#{current_user.id}"
  end
  
end
