class Admin::ActivityTypesController < ApplicationController
  before_action :set_activity_type, only: [:show, :edit, :update, :destroy]
  before_action :authorize_activity_type, only: [:show, :edit, :update, :destroy]
  before_action :fix_slug, only: [:create, :update]

  layout 'container_layout'

  # GET /activity_types
  # GET /activity_types.json
  def index
    @activity_types = policy_scope(ActivityType).all
  end

  # GET /activity_types/1
  # GET /activity_types/1.json
  def show
  end

  # GET /activity_types/new
  def new
    @activity_type = ActivityType.new
    authorize @activity_type
  end

  # GET /activity_types/1/edit
  def edit
  end

  # POST /activity_types
  # POST /activity_types.json
  def create
    @activity_type = ActivityType.new(activity_type_params)
    authorize @activity_type
    respond_to do |format|
      if @activity_type.save
        format.html { redirect_to admin_activity_types_path, notice: "Категория #{@activity_type.name} создана успешно!" }
        format.json { render :show, status: :created, location: @activity_type }
      else
        format.html { render :new }
        format.json { render json: @activity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_types/1
  # PATCH/PUT /activity_types/1.json
  def update
    respond_to do |format|
      if @activity_type.update(activity_type_params)
        format.html { redirect_to admin_activity_types_path, notice: "Категория #{@activity_type.name} успешно обновлена!" }
        format.json { render :show, status: :ok, location: @activity_type }
      else
        format.html { render :edit }
        format.json { render json: @activity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_types/1
  # DELETE /activity_types/1.json
  def destroy
    @activity_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_activity_types_url, notice: "Категория #{@activity_type.name} успешно удалена!"  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_type
      @activity_type = ActivityType.friendly.find(params[:id])
    end

    def authorize_activity_type
      authorize @activity_type
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_type_params
      params.require(:activity_type).permit(:name, :slug)
    end
    def fix_slug
      params[:activity_type][:slug] = nil if params[:activity_type][:slug].blank?
    end
end
