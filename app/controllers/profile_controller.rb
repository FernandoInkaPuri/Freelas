class ProfileController < ApplicationController
   before_action :authenticate_user!, only: [:set_favorite]
   before_action :authenticate_professional!, only: [:new, :create]
   before_action :authenticate_person, only: [:show]
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
        favorite = FavoriteProfessional.where(user:current_user, professional: @profile.professional)
        favorite.each{|fav| return @fav = true if fav.favorited? }
      end
    end

    def set_favorite
      @profile = Profile.find(params[:id])
      favorito = FavoriteProfessional.where(user:current_user, professional: @profile.professional)
      if favorito !=[] && favorito != nil
         favorito.each do |fav| 
            if fav.favorited?
              fav.unfavorited! 
            elsif fav.unfavorited?
              fav.favorited! 
            end
         end
         redirect_back(fallback_location: root_path)
      else
        favorite = FavoriteProfessional.new(user:current_user, professional: @profile.professional)
        if favorite.save
          redirect_to @profile
        end
      end
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