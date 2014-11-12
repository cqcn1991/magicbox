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

    def external_url(url)
      'http://' + url
    end
end
