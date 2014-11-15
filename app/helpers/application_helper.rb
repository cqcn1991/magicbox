# encoding: utf-8
module ApplicationHelper
    def url_with_protocol(url)
      /^http/i.match(url) ? url : "http://#{url}"
    end

    def nav_link(link_text, link_path)
      class_name = current_page?(link_path) ? 'active' : nil

      content_tag(:li, :class => class_name) do
        link_to link_text, link_path
      end
    end

    def tag_link(post, link_path)

      if post.category == '心灵'
        category = 'mental'
        label_class = 'danger'
      elsif post.category == '新品'
        category = 'new'
        label_class = 'primary'
      elsif post.category == '纸牌'
        category = 'card'
        label_class = 'info'
      end
      if category
        link_to(category_posts_path(category), class: 'no-underline') do
          content_tag(:span, :class => "label label-#{label_class}") do
            post.category
          end
        end
      end
    end

    def external_url(url)
      'http://' + url
    end

end
