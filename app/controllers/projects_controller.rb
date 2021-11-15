class ProjectsController < ApplicationController
   before_action :authenticate_user!, only: [:new, :create, :accepted, :close_registration, :close_project]
   before_action :authenticate_professional!, only: [:my_proposals, :user_favorite, :feedbacks]
   before_action :authenticate_person, only: [:team, :my_projects]
   def new
         @project = Project.new
   end

   def create
      @project = Project.new(parametros)
      @project.user = current_user
      if @project.save
         redirect_to root_path
      else
         render :new
      end
   end
   
   def show 
      if professional_signed_in?
         if current_professional.pending?
            redirect_to new_profile_path
         end
         if can_see
           @project = Project.find(params[:id])
           proposals = Proposal.where(project: @project, status_proposal: "accepted")
           favorito = FavoriteUser.where(user:@project.user, professional: current_professional)
           favorito.each{|fav|return @favorite = true if fav.preferred?}
           proposals.each{|prop| return @team = true if prop.professional == current_professional }
         end
      elsif can_see
        @project = Project.find(params[:id])
        @propostas = Proposal.where(project_id: @project.id, status_proposal: "not_rated") if @project.user == current_user
      end
   end

   def search
      projectos = Project.where('title like ? OR description like ? OR skills like ?',
      "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
      @projects = projectos.where(open_registration: true, open: true)
      @pesquisa = params[:query]
   end
   
   def my_proposals
      @proposals = current_professional.proposals
   end

   def close_registration
      project = Project.find(params[:id])
      if project.user == current_user
        project.update_column(:open_registration, false)
        redirect_to project
      end
   end

   def team
       projecto = Project.find(params[:id])
       propostas = Proposal.where(project: projecto, status_proposal: 5)
       approved = false
       propostas.each{|prop| approved = true if prop.professional == current_professional}
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
      if project.user == current_user
        project.update_column(:open, false)
        redirect_to new_project_feedback_path(project.id), notice: "Projeto encerrado com sucesso! Aproveite e dê o feedback dos profissionais que participaram "  
      end
   end

   def my_projects
      if user_signed_in?
        @projects = Project.where(user: current_user)
      elsif professional_signed_in?
        proposals = Proposal.where(professional: current_professional, status_proposal: 5)
        @projects =[]
        proposals.each{|prop| @projects << Project.find(prop.project_id)}
      end
   end

   def feedbacks
      proposals = Proposal.where(professional: current_professional, status_proposal: 5)
      projects = []
      proposals.each{|prop|projects << prop.project }
      @fb_user = []
      @fb_proj = []
      projects.each do |proj|
         fb_u = Feedback.where(project: proj, 
                                   professional: current_professional, 
                                   feedback_type: 10)   
         fb_p = Feedback.where(project: proj, 
                                   professional: current_professional, 
                                   feedback_type: 15)  
         @fb_user << proj if fb_u == [] || fb_u == nil                                                  
         @fb_proj << proj if fb_p == [] || fb_p == nil 
      end
      @feedback = Feedback.new
   end

   def user_favorite
      project = Project.find(params[:id])
      favorito = FavoriteUser.where(user: project.user, professional: current_professional)
      if favorito !=[] && favorito != nil
         favorito.each do |fav| 
            if fav.preferred?
              fav.unpreferred! 
              redirect_back(fallback_location: root_path)
            elsif fav.unpreferred?
              fav.preferred! 
              redirect_back(fallback_location: root_path) 
            end
         end
      else
        favorite = FavoriteUser.new(user:project.user, professional: current_professional)
        if favorite.save
          redirect_to project
        end
      end
   end
   
   private

   def parametros
      params.require(:project).permit(:title, :description, :skills,:modality, :max_value, 
                                      :limit_date, :start_date, :end_date)
   end
   
   def aprovado
      proposals = Proposal.where(project: @project, status_proposal: 5)
      professionals = proposals.professionals
   end

   def can_see
      project = Project.find(params[:id])
      if professional_signed_in?
        proposals = Proposal.where(project: project, status_proposal: 5)
        aprovado = false 
        proposals.each{|prop| return aprovado = true if prop.professional == current_professional}
        return true if aprovado && project.open 
        return true if project.open && project.open_registration 
      elsif user_signed_in?
         return true if project.user == current_user && project.open 
         return true if project.open && project.open_registration 
      else
         return true if project.open && project.open_registration
      end
   end
end