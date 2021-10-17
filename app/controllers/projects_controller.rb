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
      else 
         project = Project.find(params[:id])
         @user = User.find(project.user_id)
         if user_signed_in? && current_user == @user
            @project = Project.find(params[:id])
            @project.user = current_user
            #@project_id = params[:id]
         end
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

   def accepted
      @project = Project.find(params[:project_id])
      @proposals = Proposal.where('status_proposal = ? OR project_id = ?',
      5, @project)
   end
   private

   def parametros
      params.require(:project).permit(:title, :description, :skills,:modality, :max_value, 
                                      :limit_date, :start_date, :end_date)
   end
end