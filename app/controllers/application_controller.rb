class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :namespace, :display_headline_and_article!, :hide_headline_and_article!, :display_headline_and_article?

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

end
