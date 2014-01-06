class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (!request.fullpath.match("/users/") &&
     !request.xhr?) # don't store ajax calls
     session[:previous_url] = request.fullpath
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to plans_url #, :alert => exception.message
  end


  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :name, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :name, :password, :password_confirmation, :current_password) }
    end

    def after_update_path_for(resource)
      projects_path || root_path
    end



    def after_sign_in_path_for(resource)
      Rails.logger.debug "**********: in after_sign_in_path_for in ApplicationController"
      if session[:previous_url] && session[:previous_url] == "/"
      	if current_user.has_role? :crew or current_user.has_role? :admin or current_user.has_role? :subscriber
          projects_path
        else
          plans_path
        end
      else
          if current_user.has_role? :crew or current_user.has_role? :admin or current_user.has_role? :subscriber
            session[:previous_url] || projects_path || root_path
          else
            session[:previous_url] || plans_path || root_path
          end
		  end
    end

end
