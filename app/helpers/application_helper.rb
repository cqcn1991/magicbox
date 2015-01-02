# encoding: utf-8
module ApplicationHelper
    def url_with_protocol(url)
      /^http/i.match(url) ? url : "http://#{url}"
    end

    def nav_link(link_text, link_path, additional_class = nil)
      recognized = Rails.application.routes.recognize_path(link_path)
      if recognized[:controller] == params[:controller] &&
          recognized[:action] == params[:action]
        class_name = 'active'
      else
        class_name = nil
      end
      if additional_class
        class_name = [class_name, additional_class ]
      end
      content_tag(:li, :class => class_name) do
        link_to link_text, link_path
      end
    end

    def selector_link(link_text, link_path, default_link = nil)
      class_name = current_page?(link_path) ? 'active' : nil
      if default_link
        class_name = 'active'
      end
      link_to link_text, link_path, class: class_name
    end

    def tag_link(item)
      if item.category == '心灵'
        category = 'mental'
        label_class = 'danger'
      elsif item.category == '新品'
        category = 'new'
        label_class = 'primary'
      elsif item.category == '纸牌'
        category = 'card'
        label_class = 'info'
      elsif item.category == '表演'
        category = 'selected'
        label_class = 'success'
      elsif item.category == '花式'
        category = 'flourish'
        label_class = 'warning'
      end
      if category
        if item.class == Post
          path = category_posts_path(item.category)
        elsif  item.class == Video
          path = category_videos_path(item.category)
        end
        link_to(path, class: 'no-underline') do
          content_tag(:span, :class => "label label-#{label_class}") do
            item.category
          end
        end
      end
    end

    def tag_nav_link(class_name, category)
      if category == '心灵'
        label_class = 'danger'
      elsif category == '新品'
        label_class = 'primary'
      elsif category == '纸牌'
        label_class = 'info'
      elsif category == '表演'
        label_class = 'success'
      elsif category == '花式'
        label_class = 'warning'
      end
      if class_name == 'post'
        path = category_posts_path(category)
      elsif class_name == 'video'
        path = category_videos_path(category)
      end
      link_to(path, class: 'no-underline') do
        content_tag(:span, :class => "label label-#{label_class}") do
          category
        end
      end
    end

    def external_url(url)
      'http://' + url
    end

  def display_time(duration)
    if !duration.blank?
      seconds = duration % 60
      minutes = (duration / 60)
      format("%02d:%02d", minutes, seconds)
    end
  end


end
