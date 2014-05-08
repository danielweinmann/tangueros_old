# coding: utf-8

module EventDecorator

  def margin
    return "0" unless self.image.width && self.image.height
    ratio = self.image.height.to_f / self.image.width
    return "0" if ratio <= 0.382
    "-#{(ratio / 2.0 * 100) - 38.2}%"
  end

  def complete_profile?
    return if self.description.blank?
    true
  end

  def complete_profile_message
    if self.description.blank?
      "Que tal adicionar uma descrição para seu evento? #{link_to '#description', 'Clique aqui'} e comece agora mesmo :D"
    end
  end

end
