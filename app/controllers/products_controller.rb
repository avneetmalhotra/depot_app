class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if params[:category_id]
      category = Category.find_by(id: params[:category_id].to_i)
        @products = category.products
    else
      @products = Product.includes(:images, :ratings)
    end
    
    respond_to do |format|
      format.html
      format.json { render json: Product.joins(:categories).pluck(:title, 'categories.name') }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    get_rating_object
  end

  # GET /products/new
  def new
    @product = Product.new
    associate_images(3)
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: t('.create_flash') }
        format.json { render :show, status: :created, location: @product }
      else
        associate_images(3)
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: t('.update_flash') }
        format.json { render :show, status: :ok, location: @product }

        @products = Product.all
        ActionCable.server.broadcast 'products', html: render_to_string('store/index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    respond_to do |format|
      if @product.destroy
        format.html { redirect_to products_url, notice: t('.destroy_flash') }
        format.json { head :no_content }
      else
        format.html { redirect_to products_url, notice: @product.errors.full_messages.join }
      end
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updates_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :enabled, :discount_price, :permalink, images_attributes: [:uploaded_image], category_ids: [])
    end

    def associate_images(no_of_images)
     no_of_images.times { @product.images.build }
    end

    def get_rating_object
      if @product.ratings.exists?
        @rating = Rating.new
        @product.ratings.each do |rating|
          if rating.user == current_user
            @rating = rating
            break
          end
        end
      else
        @rating = Rating.new
      end
    end

end
