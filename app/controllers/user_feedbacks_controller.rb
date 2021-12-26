class UserFeedbacksController < ApplicationController
  before_action :authenticate_professional!, only: %i[create]

  def create
    project = Project.find(params[:project_id])
    user_feedback = current_professional.user_feedbacks.new(user_params)
    user_feedback.project_id = project.id
    user_feedback.user = project.user
    if user_feedback.save
      redirect_to feedbacks_projects_path,
                  notice: "Feedback de #{project.user.email} enviado com sucesso!"
    else
      redirect_to feedbacks_projects_path, notice: 'Preencha os campos corretamente!'
    end
  end

  private

  def user_params
    params.require(:user_feedback).permit(:opinion, :grade)
  end
end
