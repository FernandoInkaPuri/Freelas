class ProfessionalFeedbacksController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    @prof_feedback = current_user.professional_feedbacks.new(prof_params)
    @prof_feedback.professional_id = params[:professional_id]
    if @prof_feedback.save
      redirect_to feedbacks_projects_path,
                  notice: "Feedback de #{@prof_feedback.professional.profile.social_name} enviado com sucesso!"
    else
      redirect_to feedbacks_projects_path, notice: t('.failure')
    end
  end

  private

  def prof_params
    params.require(:professional_feedback).permit(:opinion, :grade)
  end
end
