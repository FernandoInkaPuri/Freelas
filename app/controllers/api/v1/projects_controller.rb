class Api::V1::ProjectsController < Api::V1::ApiController
  def index
    @projects = Project.all
    render json: @projects.as_json(except: %i[created_at updated_at])
  end

  def show
    @projects = Project.find(params[:id])
    render json: @projects.as_json(except: %i[created_at updated_at])
  end

  def create
    @project = Project.create!(project_params)
    render status: 201, json: @project
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :skills, :max_value, :limit_date, 
                                    :start_date,:end_date, :modality, :user_id)
  end
end