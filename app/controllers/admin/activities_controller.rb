class Admin::ActivitiesController<ApplicationController
  before_action :set_activity, only: [:edit, :update, :destroy]
  before_action :authorize_activity, only: [:edit, :update, :destroy]
  before_action :set_categories, only: [:new, :create, :edit, :update]


  layout 'container_layout'

  def index
    @activities = policy_scope(Activity).all
  end

  # GET /categories/new
  def new
    @activity = Activity.new
    authorize @activity
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @activity = current_user.activities.build(activity_params)
    authorize @activity
    respond_to do |format|
      if @activity.save
        format.html { redirect_to admin_activities_path, notice: "Активность #{@activity.name} создана успешно!" }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to admin_activities_path, notice: "Активность #{@activity.name} успешно обновлена!" }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to admin_activities_path, notice: "Активность #{@activity.name} успешно удалена!"  }
      format.json { head :no_content }
    end
  end

  private

  def set_activity
    @activity = Activity.friendly.find(params[:id])
  end
  def set_categories
    @root_categories = Category.roots
  end
  def authorize_activity
    authorize @activity
  end
  def activity_params
    params.require(:activity).permit(:age_limit, :preview, :cover, :name, :cost, :date_end, :date_start, :description, :short_description, :payment_type, :activity_type_id, :tag_list, category_ids: [])
  end
end