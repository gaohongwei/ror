https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in

class ApplicationController < ActionController::Base
  
  private
  def after_sign_in_path_for(resource)
    session['user_return_to'] || '/'
  end
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end  
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      new_user_session_path
    elsif resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end
  
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  if params[:redirect_to].present?
    store_location_for(resource, params[:redirect_to])  
  end

   def new
     self.resource = resource_class.new(sign_in_params)
     store_location_for(resource, params[:redirect_to])
     super
   end

The default url to be used after signing in. 
This is used by all Devise controllers and you can overwrite it in your ApplicationController to 
provide a custom hook for a custom resource.

By default, it first tries to find a valid resource_return_to key in the session, 
then it fallbacks to resource_root_path, otherwise it uses the root path. 
For a user scope, you can define the default url in the following way:
