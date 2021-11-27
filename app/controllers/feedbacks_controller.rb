class FeedbacksController < ApplicationController
  before_action :authenticate_person, only: %i[new create]
  def new
    feedback_new
    @feedback = Feedback.new
  end

  def create
    if user_signed_in?
      create_f_to_prof
    elsif professional_signed_in?
      create_f_user
    end
  end

  private

  def feedback_new
    @project = Project.find(params[:project_id])
    @propostas = @project.proposals.where(status_proposal: 5)
    if user_signed_in? && @project.user == current_user
      @feedbacks = Feedback.where(project_id: params[:project_id])
      @propostas.each do |prop|
        if @feedbacks == []
          @proposals = @project.proposals.where(status_proposal: 5)
        else
          @feedbacks.each do |fb|
            @proposals << prop if prop.professional_id != fb.professional_id
          end
        end
      end
    elsif professional_signed_in? propostas.professionals.include?(current_professional)

    end
  end

  def create_f_to_prof
    @feedback = Feedback.new(params.require(:feedback).permit(:opinion, :nota))
    @feedback.user = current_user
    @feedback.project = Project.find(params[:project_id])
    @feedback.professional = Professional.find(params[:professional_id])
    @feedback.prof_f!
    if @feedback.save
      redirect_to new_project_feedback_path(@feedback.project.id),
                  notice: "Feedback de #{@feedback.professional.profile.social_name} enviado com sucesso!"
    else
      render :new
    end
  end

  def create_f_user
    @feedback = Feedback.new(params.require(:feedback).permit(:opinion, :nota, :feedback_type))
    @feedback.professional = current_professional
    @feedback.project = Project.find(params[:project_id])
    @feedback.user = User.find(params[:user_id])
    if @feedback.save
      redirect_to feedbacks_projects_path, notice: "Feedback de #{@feedback.user.email} enviado com sucesso!"
    else
      redirect_to feedbacks_projects_path
    end
  end
end
