# encoding: utf-8
module CafeDigestHelper
  def cafe_tag_nav_link(class_name, category)
    if category == 'mental'
      label_class = 'danger'
    elsif category == 'new'
      display_category = 'new product'
      label_class = 'primary'
    elsif category == 'card'
      label_class = 'info'
    end
    if class_name == 'post'
      path = cafe_category_posts_path(category)
    end
    link_to(path, class: 'no-underline') do
      content_tag(:span, :class => "label label-#{label_class}") do
        display_category || category
      end
    end
  end

  def cafe_tag_link(item)
    if item.category == 'mental'
      label_class = 'danger'
    elsif item.category == 'new'
      display_category = 'new product'
      label_class = 'primary'
    elsif item.category == 'card'
      label_class = 'info'
    end
    if !item.category.blank?
      if item.class == Post
        path = cafe_category_posts_path(item.category)
      end
      link_to(path, class: 'no-underline') do
        content_tag(:span, :class => "label label-#{label_class}") do
          display_category || item.category
        end
      end
    end
  end
end