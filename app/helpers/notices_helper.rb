module NoticesHelper
  def short_auto_link(text)
    auto_link(text, :html => { :target => '_blank' }) do |text|
      truncate(text, :length => 30)
    end
  end
end
