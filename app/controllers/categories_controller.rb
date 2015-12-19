class CategoriesController < ApplicationController

	def index
		@categories = Category.all	
	end

	def show
		@category = Category.find(params[:id])
		@product = @category.products
	end
end
