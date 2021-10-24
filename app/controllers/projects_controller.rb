class ProjectsController < ApplicationController
   before_action :authenticate_user!, only: [:new, :create, :accepted]

   def new
         @project = Project.new()
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
         @project = Project.find(params[:id])
      elsif user_signed_in? 
         @project = Project.find(params[:id])
         @user = User.find(@project.user_id)
         if user_signed_in? && current_user == @user
            @project.user = current_user
            #@project_id = params[:id]
         end
      else
         @project = Project.find(params[:id])
      end
   end

   def search
      @projects = Project.where('title like ? OR description like ? OR skills like ? ',
      "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%" )
      @pesquisa = params[:query]
   end
   
   def my_proposals
      @proposals = current_professional.proposals
   end

   def close_registration
      @project = Project.find(params[:id])
      @project.update_column(:open_registration, false)
      redirect_to @project
   end

   def team
      @project = Project.find(params[:id])
      @proposals = @project.proposals.where( status_proposal: 5)
      #@team = proposals
      #@team = @project.proposals.where(professional: current_professional, status_proposal: 5)
   end

   def close_project
      project = Project.find(params[:id])
      project.update_column(:open, false)
      redirect_to new_project_feedback_path(project.id), notice: "Projeto encerrado com sucesso! Aproveite e dê o feedback dos profissionais que participaram "  
   end

   def my_projects
      @projects = Project.where(user: current_user)
   end

   def feedbacks
      @proposals = Proposal.where(professional: current_professional, status_proposal: 5)
      @projects = []
      @proposals.each{|prop|@projects << prop.project }
      @fb_user = []
      @fb_proj = []
      @projects.each do |proj|
         @fb_u = Feedback.where(project: proj, 
                                   professional: current_professional, 
                                   feedback_type: 10)   
         @fb_p = Feedback.where(project: proj, 
                                   professional: current_professional, 
                                   feedback_type: 15)                           
         if @fb_u == [] ||  @fb_u == nil                             
           @fb_user << proj 
         end  
         if @fb_p == [] ||  @fb_p == nil                             
            @fb_proj << proj 
         end  
      end
      @feedback = Feedback.new
   end
   
   private

   def parametros
      params.require(:project).permit(:title, :description, :skills,:modality, :max_value, 
                                      :limit_date, :start_date, :end_date)
   end
end