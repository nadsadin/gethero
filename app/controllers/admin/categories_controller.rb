class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authorize_category, only: [:show, :edit, :update, :destroy]
  before_action :fix_slug, only: [:create, :update]

  layout 'container_layout'

  # GET /categories
  # GET /categories.json
  def index
    @categories = policy_scope(Category).all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    @parents = Category.roots
    authorize @category
  end

  # GET /categories/1/edit
  def edit
    @parents = Category.roots
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    authorize @category
    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_path, notice: "Категория #{@category.name} создана успешно!" }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to [:admin, @category], notice: "Категория #{@category.name} успешно обновлена!" }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: "Категория #{@category.name} успешно удалена!"  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    def authorize_category
      authorize @category
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :slug, :plural, :parent_id)
    end
    def fix_slug
      params[:category][:slug] = nil if params[:category][:slug].blank?
    end
end
