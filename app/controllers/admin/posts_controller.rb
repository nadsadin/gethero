class Admin::PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authorize_post, only: [:edit, :update, :destroy]
  before_action :fix_slug, only: [:create, :update]

  layout 'container_layout'

  # GET /categories
  # GET /categories.json
  def index
    @posts = policy_scope(Post).all
  end


  # GET /categories/new
  def new
    @post = Post.new
    authorize @post
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @post = Post.new(post_params)
    authorize @post
    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_posts_path, notice: "Страница #{@post.title} создана успешно!" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to admin_posts_path, notice: "Страница #{@post.title} успешно обновлена!" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_path, notice: "Страница #{@post.title} успешно удалена!"  }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def authorize_post
    authorize @post
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:slug, :title, :text, :preview, :description, :seo_title, :seo_description)
  end
  def fix_slug
    params[:post][:slug] = nil if params[:post][:slug].blank?
  end
end