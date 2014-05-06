class ApplicationController < ActionController::Base

  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :namespace, :display_headline_and_article!, :hide_headline_and_article!, :display_headline_and_article?

  after_action :verify_authorized, unless: :devise_controller?
  after_action :verify_policy_scoped, unless: :devise_controller?

  def display_headline_and_article?
    !@hide_headline_and_article
  end

  def display_headline_and_article!
    @hide_headline_and_article = false
  end

  def hide_headline_and_article!
    @hide_headline_and_article = true
  end

  def namespace
    names = self.class.to_s.split('::')
    return "null" if names.length < 2
    names[0..(names.length-2)].map(&:downcase).join('_')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

end
