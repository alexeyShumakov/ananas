module TextHelper
  def to_markdown(context)
    context = emojify(context)
    context = oneboxefy(context)
    context = Kramdown::Document.new(context).to_html.html_safe
  end
  def emojify(content)
    content.to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{ActionController::Base.helpers.image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end
  end

  def oneboxefy(content)
    content ||= ''
    threads = []
    matches = content.scan(/(\[preview\](https?:\/\/[\S]+)\[\/preview\])/)
    matches.each do |match|
      threads << Thread.new(match, content) do |match, content|
        onebox = Onebox.preview(match[1]).to_s rescue match[0]
        onebox = match[0] if onebox.blank?
        content.gsub! match[0], onebox
      end
    end
    threads.each { |thr| thr.join }
    content
  end
end
