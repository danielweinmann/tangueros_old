class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :namespace

  def namespace
    names = self.class.to_s.split('::')
    return "null" if names.length < 2
    names[0..(names.length-2)].map(&:downcase).join('_')
  end

end
