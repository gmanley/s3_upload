# encoding: UTF-8
module ApplicationHelper

  BOOTSTRAP_FLASH_CLASS = {
    alert:   'warning',
    notice:  'info',
  }

  def bootstrap_flash_class(type)
    BOOTSTRAP_FLASH_CLASS[type] || type.to_s
  end

  def flash_messages
    flash.each do |type, message|
      flash_message(type, message) if message.is_a?(String)
    end
  end

  private
  def flash_message(type, message)
    haml_tag :div, class: "alert alert-#{bootstrap_flash_class(type)} fade in" do
      haml_tag 'a.close', '×', data: {dismiss: 'alert'}
      haml_concat(message)
    end
  end


  def breadcrumb(text, link = nil)
    if link
      haml_tag :li do
        haml_tag :a, text, href: link
        haml_tag 'span.divider', '/'
      end
    else
      haml_tag 'li.active', text
    end
  end
end
