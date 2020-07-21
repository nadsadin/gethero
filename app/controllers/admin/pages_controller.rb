class Admin::PagesController < ApplicationController
  before_action :set_page, only: [:edit, :update, :destroy]
  before_action :authorize_page, only: [:edit, :update, :destroy]
  before_action :fix_slug, only: [:create, :update]

  layout 'container_layout'

  # GET /categories
  # GET /categories.json
  def index
    @pages = policy_scope(Page).all
  end


  # GET /categories/new
  def new
    @page = Page.new
    authorize @page
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @page = Page.new(page_params)
    authorize @page
    respond_to do |format|
      if @page.save
        format.html { redirect_to admin_pages_path, notice: "Страница #{@page.title} создана успешно!" }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to admin_pages_path, notice: "Страница #{@page.title} успешно обновлена!" }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to admin_pages_path, notice: "Страница #{@page.title} успешно удалена!"  }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.friendly.find(params[:id])
  end

  def authorize_page
    authorize @page
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params.require(:page).permit(:slug, :title, :text)
  end

  def fix_slug
    params[:page][:slug] = nil if params[:page][:slug].blank?
  end
end