ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  error_field = %(<p class="custom-error-message" style="margin:5px 0px;color:red">&nbsp;%{error}</p>)
  if html_tag =~ /^<label/
    html_tag.html_safe
  else
    error_message = if instance.error_message.kind_of?(Array)
      instance.error_message.inject("") do |err_msg, message|
        err_msg << (error_field % {error: message})
      end
    else
      error_field % {error: instance.error_message}
    end
    "<div class=\"field-with-errors\" style='border-left: 3px solid red'>#{html_tag}</div>#{error_message}".html_safe
  end
end
