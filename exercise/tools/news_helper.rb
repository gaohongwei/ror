module NewsHelper
  def tweet_text(text)
    text_with_tags = text
    text.scan(/#\S+/).each do |tag|
      text_with_tags = text_with_tags.gsub(tag, "#{tag}")
    end

    text_with_tags
  end

  def news_filters 
    params[:cookie]=cookies[:filter_group]        
    cookies[:filter_group].inject('') do |html, filter|
      html_class = @filter == filter ? 'active' : ''
      type=tt(filter)
      html.concat(
        "<li class='#{html_class}'><a href='/news/#{type}'>#{type}</a></li>"
      )
    end.html_safe
  end

  def link_to_article(article)
    link=article.permalink
    if link.nil? || link.empty?
      #making sure leaving out a permalink doesn't crash the news page
        link="/news/types/#{tt('news')}"  
        link_to article.title, link             
    else
      if link.size>4 && link[0,4] == 'http'
        link_to article.title, link, target: "_blank" 
      else
        link="/papers/#{link}"  
        link_to article.title, link
      end 
    end
  end
end
