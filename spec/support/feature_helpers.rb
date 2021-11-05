module FeatureHelpers
    def feedback_contratador
        find(:css, "#feedback_opinion", match: :first)
    end
end
  
RSpec.configure do |config|
    config.include FeatureHelpers, :type => :feature
end