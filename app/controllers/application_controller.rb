require 'user_sanitizer'
require 'guide_sanitizer'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include NotificationsHelper
  
  protected

  def devise_parameter_sanitizer
    @notifications = current_user != nil ? current_user.mailbox.notifications : nil
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    elsif resource_class == Guide
      Guide::ParameterSanitizer.new(Guide, :guide, params)
    # elsif resource_class == Admin
    #   Admin::ParameterSanitizer.new(Admin, :admin, params)
    else
      super # Use the default one
    end
  end

end
