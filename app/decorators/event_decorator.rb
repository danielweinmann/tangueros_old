# coding: utf-8

module EventDecorator

  def margin
    return "0" unless self.image.width && self.image.height
    ratio = self.image.height.to_f / self.image.width
    return "0" if ratio <= 0.382
    "-#{(ratio / 2.0 * 100) - 38.2}%"
  end

  def complete_profile?
    return if self.image.blank?
    return if self.address.blank?
    return if self.description.blank?
    return if self.url.blank?
    true
  end

  def tips
    tips = []
    if self.image.blank?
      tips << "Adicione uma foto para seu evento ;) basta clicar no #{link_to 'botão abaixo', '#image'} e enviar o arquivo o/"
    end
    if self.address.blank?
      tips << "Informe o endereço do seu evento e todo mundo vai ver a localização no mapa ;) é só clicar no #{link_to 'texto abaixo', '#address'}!"
    end
    if self.description.blank?
      tips << "Que tal adicionar uma descrição para seu evento? Clique no #{link_to 'texto abaixo', '#description'} e comece agora mesmo :D"
    end
    if self.url.blank?
      tips << "Você possui uma página com mais informações sobre o evento? Clique no #{link_to 'texto abaixo', '#url'} e informe o link para todos :D"
    end
    unless self.weekly?
      tips << "Seu evento acontece toda semana no mesmo horário? Clique na #{link_to 'caixa abaixo', '#weekly'} e ele irá aparecer sempre na agenda! \\o/"
    end
    tips
  end

end
