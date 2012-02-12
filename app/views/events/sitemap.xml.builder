xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    xml.loc "http://tangoportoalegre.com.br"
    xml.priority 1.0
    xml.changefreq "daily"
  end

  @happening.each do |event|
    xml.url do
      xml.loc event.url
      xml.priority 0.8
      xml.changefreq "daily"
      xml.lastmod event.updated_at.to_date
    end
  end

  @upcoming.each do |event|
    xml.url do
      xml.loc event.url
      xml.priority 0.6
      xml.changefreq "daily"
      xml.lastmod event.updated_at.to_date
    end
  end

  @past.each do |event|
    xml.url do
      xml.loc event.url
      xml.priority 0.4
      xml.changefreq "daily"
      xml.lastmod event.updated_at.to_date
    end
  end

end