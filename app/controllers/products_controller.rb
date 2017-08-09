class ProductsController < ApplicationController
  include Pagination
  before_action :authenticate_user!,:is_admin?, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_category_names, only: [:new,:edit]
  before_action :set_pagination_params, only: [:index]

  # GET /products
  def index
    search = search_products
    if search_params[:search_term].blank?
      @products = Product.all.actives
    else
      @products = search.results
      @total = search.total
      @total_pages = search.results.total_pages
      flash[:notice] = "Products found with given criteria"
    end
  end

  # GET /products/1
  def show
     @categories = @product.categories
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    # @product.description = Category.find(params[:category][:category_id].to_i).name+" | "+@product.description
    if @product.save
      set_category
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      set_category
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  def inactives
    @products = Product.all.inactives
  end

  private # --------------------------------------------------------------------

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_category_names
      @categories = Category.all.order_by_name
    end

    def set_category
      cate_id = params[:category][:category_id]
      category_id = cate_id.empty? ? @product.categories.first : cate_id.to_i
      CategoryProduct.update_or_create(product_id:@product.id, category_id:cate_id.to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :money, :inventory, :active, :description)
    end

    def search_params
      params.permit(:search_term)
    end

    def search_products
      # Intance variable provided from Pagination Module
      page = @page
      limit= @limit
      # Eager loading!!!
      search = Product.search(include: [:categories,:category_products]) do |searcher|
        searcher.fulltext search_params[:search_term]
        searcher.paginate page: page, per_page: limit
      end
    end
end
