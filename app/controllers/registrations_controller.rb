class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, :only => [:create, :update]


  # def store_location
  #   # store last url - this is needed for post-login redirect to whatever the user last visited.
  #   if (!request.fullpath.match("/users/") &&
  #    !request.xhr?) # don't store ajax calls
  #    session[:previous_url] = request.fullpath
  #   end
  # end

  
  # protected

  #   def configure_permitted_parameters
  #     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :name, :password, :password_confirmation) }
  #     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :name, :password, :password_confirmation, :current_password) }
  #   end

  #   def after_update_path_for(resource)
  #     projects_path || root_path
  #   end

  #   def signed_in_root_path(resource)
  #     projects_path
  #   end

  #   def after_sign_in_path_for(resource)
  #     session[:previous_url] || projects_path || root_path
  #   end
end