class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # GET /products
  # GET /products.json
  def index
    @products = Product.search(params[:search])
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @category = @product.categories
    if !@product.producer.blank?
      @producer = @product.producer
    end
    @cart_action = @product.cart_action current_user.try :id
  end

  def new
      @product = Product.new
      @categories = Category.all
      @producers = Producer.all
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
    @producers = Producer.all
  end

  def create
    @product = Product.new(product_params)
    params[:category_id] ||= []
    @category = Category.find(params[:category_id])
    respond_to do |format|
      if @product.save
        @product.categories << @category
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    params[:category_id] ||= []
    @category = Category.find(params[:category_id])
    respond_to do |format|
      @product.categories.where(!@category).destroy_all
      if @product.update(product_params)
        @category.each do |c|
          if !@product.categories.include?(c)
            @product.categories << c
          end
        end
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :description, :avatar, :producer_id)
    end
end
