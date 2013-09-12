class StaticController < ApplicationController
	skip_before_action :authorize, only: [:index]
	def index       
    end

    def pricing
    end

    def terms
    end
end
