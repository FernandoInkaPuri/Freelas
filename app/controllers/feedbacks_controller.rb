class FeedbacksController < ApplicationController
  before_action :authenticate_professional!, only: %i[create]
  
  def create
    project = Project.find(params[:project_id])
    @proj_feedback = current_professional.feedbacks.new(proj_params)
    @proj_feedback.project_id = project.id
    @proj_feedback.user = project.user
    if @proj_feedback.save
      redirect_to feedbacks_projects_path, 
      notice: "Feedback de #{project.title} enviado com sucesso!"
    else
      redirect_to feedbacks_projects_path, 
      notice: "Preencha os campos corretamente"
    end
  end

  private

  def proj_params
    params.require(:feedback).permit(:opinion, :nota)
  end
end
