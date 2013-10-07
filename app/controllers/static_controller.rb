class StaticController < ApplicationController
	skip_before_action :authorize, only: [:index]
	def index       
    end

    def product
    end

    def terms
    end
end
