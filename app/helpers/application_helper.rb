module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def view_counter
    session[request.url] ||= 0
    session[request.url] += 1
  end
end
