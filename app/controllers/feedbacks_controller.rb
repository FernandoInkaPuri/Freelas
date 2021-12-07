class FeedbacksController < ApplicationController
  before_action :authenticate_person, only: %i[new create]
  def new
    if user_signed_in?
      propostas = []
      current_user.projects.each{|proj| propostas << proj.proposals.accepted }
      #@feedbacks = @project.feedbacks
      if propostas.present?
        propostas.each do |prop|
          return unless prop.present?
          
          if prop.project.feedbacks.blank?
            @proposals = propostas
          else
            prop.project.feedbacks.each do |fb|
              return if prop.professional_id == fb.professional_id
              @proposals << prop 
            end
          end
        end
      end
    elsif professional_signed_in?
      @proposals = current_professional.proposals.accepted
    end
    @feedback = Feedback.new
  end

  def create
    project = Project.find(params[:project_id])
    @proj_feedback = current_professional.feedbacks.new(proj_params)
    @proj_feedback.project = params[:project_id]
    if @prof_feedback.save
      redirect_to feedbacks_projects_path, 
      notice: "Feedback de #{@prof_feedback.professional.profile.social_name} enviado com sucesso!"
    else
      redirect_to feedbacks_projects_path, 
      notice: "Preencha os campos corretamente"
    end
  end

  private

  def feedback_new
    @project = Project.find(params[:project_id])
    @propostas = @project.proposals.accepted
    if user_signed_in? && @project.user == current_user
      @feedbacks = @project.feedbacks
      @propostas.each do |prop|
        if @feedbacks.blank?
          @proposals = @propostas
        else
          @feedbacks.each do |fb|
            @proposals << prop if prop.professional_id != fb.professional_id
          end
        end
      end
    elsif professional_signed_in? propostas.professionals.include?(current_professional)
      @proposals = @propostas if @proposta.present?
    end
  end

  def create_f_to_prof
    @feedback = Feedback.new(params.require(:feedback).permit(:opinion, :nota))
    @feedback.user = current_user
    @feedback.project = Project.find(params[:project_id])
    @feedback.professional = Professional.find(params[:professional_id])
    if @feedback.save
      @feedback.prof_f!
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
      message = "Feedback de #{@feedback.user.email} enviado com sucesso!" if @feedback.feedback_type == 'user_f'
      message = "Feedback de #{@feedback.project.title} enviado com sucesso!" if @feedback.feedback_type == 'project_f'
      redirect_to projects_feedbacks_path, notice: message
    else
      render :new
    end
  end

  def prof_params
    params.require(:professional_feedback).permit(:opinion, :nota)
  end
end
