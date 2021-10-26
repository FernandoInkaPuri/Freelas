class ProfileController < ApplicationController


    def new
        if current_professional.pending?
            @profile = Profile.new
        else
            redirect_to profile_path
        end
    end

    def create
        @profile = Profile.new(profile_params)
        @profile.professional = current_professional
        if @profile.save   
            current_professional.completed!              
            redirect_to @profile      
        else
            render :new
        end
    end

    def show 
      if professional_signed_in? 
        if current_professional.pending?
            redirect_to new_profile_path
        else
            @profile = Profile.find(params[:id])
            nota
        end
      elsif user_signed_in? 
        @profile = Profile.find(params[:id])  
        nota
        @favorite = FavoriteProfessional.where(user:current_user, professional: @profile.professional)
      end
    end

    def set_favorite
      @profile = Profile.find(params[:id])
      @favorite = FavoriteProfessional.new(user:current_user, professional: @profile.professional)
      @favorite.favorited!
      redirect_to profile_path(professional_id: params[:professional_id] )
    end

    private

    def profile_params
        params.require(:profile).permit(:name, :social_name, :birth_date, 
                                        :formation, :description, :experience, :status_profile, :avatar )
    end

    def nota
      @feedbacks = Feedback.where(professional: @profile.professional)
        n = []
        @feedbacks.each do |fb| 
          if fb.nota != [] && fb.nota != nil
            n << fb.nota
            @nota = n.reduce{|sum,num| sum + num}/n.size
          end
        end
    end

end