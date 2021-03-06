# encoding: utf-8
module ApplicationHelper
    def url_with_protocol(url)
      /^http/i.match(url) ? url : "http://#{url}"
    end

    # Usage: <%= nav_link  'Trending', pop_path %>
    def nav_link(link_text, link_path, additional_class = nil, glyphicon = nil )
      recognized = Rails.application.routes.recognize_path(link_path)
      if recognized[:controller] == params[:controller]
        if recognized[:controller] != 'static_pages'
          class_name = 'active'
        else
          class_name = 'active' if recognized[:action] == params[:action]
        end
      else
        class_name = nil
      end
      class_name = [class_name, additional_class ] if additional_class
      content_tag(:li, :class => class_name) do
        if glyphicon
          link_to link_path do
            content_tag(:span, nil, class: glyphicon) + " " + link_text
          end
        else
          link_to link_text, link_path
        end
      end
    end

    def nav_link2(link_text, link_path)
      content_tag(:li, class: 'active') do
        link_to link_path do
          content_tag(:span, nil, class: "glyphicon glyphicon-star") +  link_text
        end
      end
    end

    def accurate_nav_link(link_text, link_path)
      recognized = Rails.application.routes.recognize_path(link_path)
      if recognized[:controller] == params[:controller] && recognized[:action] == params[:action]
          class_name = 'active'
      else
        class_name = nil
      end
      content_tag(:li, :class => class_name) do
        link_to link_text, link_path
      end
    end

    # Usage:
    # selector_link('This is New', tab: 'new')
    # link_to link_text, url_for(tab: 'new'), class: ('active'if params[:tab] == 'new')
    def selector_link(link_text, link)
      key = link.keys.first
      class_name = 'active'if params[key].to_s == link[key]
      link_to link_text, url_for(link), class: class_name
    end

    def selector_link2(link_text, link)
      key = link.keys.first
      class_name = 'active'if params[key].to_s == link[key]
      content_tag :li, class: class_name do
        link_to link_text, url_for(link)
      end
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
