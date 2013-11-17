class StaticController < ApplicationController
	skip_before_action :authorize, only: [:index, :product]
	def index       
    end

    def product
    end

    def terms
    end

    def welcome
    end
end
