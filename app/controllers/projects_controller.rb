class ProjectsController < ApplicationController
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
         else
            @project = Project.find(params[:id])
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
   


   private

   def parametros
      params.require(:project).permit(:title, :description, :skills,:modality, :max_value, 
                                      :limit_date, :start_date, :end_date)
   end
end