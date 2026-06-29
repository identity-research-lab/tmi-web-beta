module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def title_label(text)
    content_for(:title_label) { text }
  end

  def title_headline(text)
    content_for(:title_headline) { text }
  end

  def active_nav(text)
    content_for(:active_nav) { text }
  end
  
end
