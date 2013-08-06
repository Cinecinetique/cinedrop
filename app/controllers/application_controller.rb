class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  protected

	def authorize
		unless User.find_by(id: session[:user_id])
			if (request.local?)
				redirect_to login_url, notice: "Please log in"
			else
				redirect_to :protocol => 'https://', 
	            			:controller => 'sessions', 
	            			:action => 'new'
        	end
		end
	end
end
