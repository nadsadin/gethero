class Admin::PersonalPagesController < ApplicationController

  before_action :set_personal_page, only: [:edit, :update, :destroy]
  before_action :authorize_personal_page, only: [:edit, :update, :destroy]
  before_action :set_categories, only: [:new, :create, :edit, :update]

  layout 'container_layout'

  # GET /categories
  # GET /categories.json
  def index
    authorize :personal_page
    @personal_pages = policy_scope(PersonalPage).all
  end


  # GET /categories/new
  def new
    redirect_to edit_admin_personal_page_path(current_user.personal_page) if current_user.personal_page.present?
    @personal_page = PersonalPage.new
    authorize @personal_page
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    redirect_to edit_admin_personal_page_path(current_user.personal_page) if current_user.personal_page.present?
    @personal_page = current_user.build_personal_page(personal_page_params)
    authorize @personal_page
    respond_to do |format|
      if @personal_page.save
        format.html { redirect_to admin_root_path, notice: "Страница #{@personal_page.nickname} создана успешно!" }
        format.json { render :show, status: :created, location: @personal_page }
      else
        format.html { render :new }
        format.json { render json: @personal_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @personal_page.update(personal_page_params)
        format.html { redirect_to admin_root_path, notice: "Страница #{@personal_page.nickname} успешно обновлена!" }
        format.json { render :show, status: :ok, location: @personal_page }
      else
        format.html { render :edit }
        format.json { render json: @personal_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @personal_page.destroy
    respond_to do |format|
      format.html { redirect_to admin_personal_pages_path, notice: "Страница #{@personal_page.nickname} успешно удалена!"  }
      format.json { head :no_content }
    end
  end
  private
  def set_personal_page
    @personal_page = PersonalPage.friendly.find(params[:id])
  end
  def set_categories
    @root_categories = Category.roots
  end
  def authorize_personal_page
    authorize @personal_page
  end
  def personal_page_params
    params.require(:personal_page).permit(:about, :nickname, :preview, :avatar, :cover, :short_description, :name, :tag_list, category_ids: [])
  end
end