# encoding: utf-8
module PostsHelper
  def show_source_name(item)
    if item.source == 'cafe'
      'cafe'
    elsif item.source == 'tieba'
      '贴吧'
    end
  end
end
