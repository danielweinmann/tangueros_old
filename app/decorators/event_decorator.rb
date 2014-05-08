# coding: utf-8

module EventDecorator

  def margin
    return "0" unless self.image.width && self.image.height
    ratio = self.image.height.to_f / self.image.width
    return "0" if ratio <= 0.382
    "-#{(ratio / 2.0 * 100) - 38.2}%"
  end

  def complete_profile?
    return unless self.image.present?
    # return unless self.address.present?
    # return unless self.description.present?
    true
  end

end
