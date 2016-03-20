class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user

  helper :all
  include ShallowRouteHelper

  self.allow_forgery_protection = false
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '777e12608199867e6528eb1a3556d20d'

  before_filter :correct_webkit_and_ie_accept_headers
  before_filter :autoinstall
  before_filter :activate_authlogic
  before_filter :require_user

  private

  def correct_webkit_and_ie_accept_headers
    request.accepts.sort! { |_x, y| y.to_s == 'text/javascript' ? 1 : -1 } if request.xhr?
  end

  def autoinstall
    redirect_to new_install_path if User.count == 0
  end

  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end

  def require_admin
    unless current_user.admin?
      head :forbidden
      return false
    end
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_path
      return false
    end
  end

  def require_no_user
    if current_user
      flash[:notice] = "You must be logged out to access this page"
      redirect_to '/'
      return false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_to_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def redirect_to_last_client_or_back_or_default
    if current_user.last_client
      redirect_to invoices_path(current_user.last_client)
    else
      redirect_to_back_or_default '/'
    end
  end
end
