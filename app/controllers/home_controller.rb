class HomeController < ApplicationController
    def index
        @projects = Project.where(open: true)
    end
end