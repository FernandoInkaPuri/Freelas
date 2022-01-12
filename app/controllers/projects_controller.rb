class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create accepted close_registration close_project]
  before_action :authenticate_professional!, only: %i[my_proposals user_favorite]
  before_action :authenticate_person, only: %i[team my_projects feedbacks]
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(parametros)
    @project.user = current_user
    if @project.save
      redirect_to @project, notice: t('.success')
    else
      render :new, alert: t('.failure')
    end
  end

  def show
    if professional_signed_in?
      redirect_to new_profile_path if current_professional.pending?
      if can_see
        @project = Project.find(params[:id])
        proposals = @project.proposals.accepted
        favorito = FavoriteUser.where(user: @project.user, professional: current_professional)
        favorito.each { |fav| return @favorite = true if fav.preferred? }
        proposals.each { |prop| return @team = true if prop.professional == current_professional }
      end
    elsif can_see
      @project = Project.find(params[:id])
      return unless @project.user == current_user

      @propostas = @project.proposals.not_rated
    end
  end

  def search
    projectos = Project.where('title like ? OR description like ? OR skills like ?',
                              "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
    @projects = projectos.where(open_registration: true, open: true)
    @pesquisa = params[:query]
  end

  def my_proposals
    @proposals = []
    current_professional.proposals.each { |prop| @proposals << prop if prop.project.open }
  end

  def close_registration
    project = Project.find(params[:id])
    return unless project.user == current_user

    project.update_column(:open_registration, false)
    redirect_to project, notice: t('.close')
  end

  def team
    projecto = Project.find(params[:id])
    propostas = projecto.proposals.accepted
    approved = false
    propostas.each { |prop| approved = true if prop.professional == current_professional }
    if approved && professional_signed_in?
      @project = projecto
      @proposals = propostas
    elsif user_signed_in? && projecto.user == current_user
      @project = projecto
      @proposals = propostas
    end
  end

  def close_project
    project = Project.find(params[:id])
    return unless project.user == current_user

    project.update_column(:open, false)
    redirect_to feedbacks_projects_path, notice: t('.close')
  end

  def my_projects
    if user_signed_in?
      @projects = current_user.projects.where(open: true)
    elsif professional_signed_in?
      @projects = []
      current_professional.proposals.accepted.each { |prop| @projects << prop.project }
    end
  end

  def feedbacks
    if professional_signed_in?
      @proposals_projects = []
      @proposals_users = []
      current_professional.proposals.accepted.each do |prop|
        @proposals_projects << prop if current_professional.feedbacks.where(project_id: prop.project.id).blank?
        @proposals_users << prop if current_professional.user_feedbacks.where(project_id: prop.project.id).blank?
      end
      @proj_feedback = Feedback.new
      @user_feedback = UserFeedback.new
    elsif user_signed_in?
      @proposals = []
      current_user.projects.each do |proj|
        proj.proposals.accepted.each do |prop|
          return if ProfessionalFeedback.where(professional_id: prop.professional_id, user: current_user).present?

          @proposals << prop
        end
      end
      @prof_feedback = ProfessionalFeedback.new
    end
  end

  def user_favorite
    project = Project.find(params[:id])
    favorito = FavoriteUser.where(user: project.user, professional: current_professional)
    if favorito.present?
      favorito.each do |fav|
        return fav.unpreferred!, redirect_back(fallback_location: root_path) if fav.preferred?
        return fav.preferred!, redirect_back(fallback_location: root_path) if fav.unpreferred?
      end
    else
      favorite = FavoriteUser.new(user: project.user, professional: current_professional)
      redirect_to project if favorite.save
    end
  end

  private

  def parametros
    params.require(:project).permit(:title, :description, :skills, :modality, :max_value,
                                    :limit_date, :start_date, :end_date)
  end

  def aprovado
    proposals = Proposal.where(project: @project, status_proposal: 5)
    proposals.professionals
  end

  def can_see
    project = Project.find(params[:id])
    if professional_signed_in?
      proposals = project.proposals.accepted
      aprovado = false
      proposals.each { |prop| return aprovado = true if prop.professional == current_professional }
      return true if aprovado && project.open
      return true if project.open && project.open_registration
    elsif user_signed_in?
      return true if project.user == current_user && project.open
      return true if project.open && project.open_registration
    elsif project.open && project.open_registration
      true
    end
  end
end
