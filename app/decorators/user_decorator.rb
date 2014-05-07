# coding: utf-8

module UserDecorator

  def thumbnail
    self.image.present? ? self.image.url(:thumb) : "user.svg"
  end

end
