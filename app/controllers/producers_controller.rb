class ProducersController < ApplicationController

	def index
		@producers = Producer.all
	end

	def show
		@producer = Producer.find(params[:id])
		@products = @producer.products
	end

	def new
		@producer = Producer.new
	end
end
