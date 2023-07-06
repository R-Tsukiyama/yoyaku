ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    if instance.kind_of?(ActionView::Helpers::Tags::Label)
      html_tag.html_safe
    else
      method_name = instance.instance_variable_get(:@method_name)
      errors = instance.object.errors.full_messages_for(method_name)
      errors_tag = errors.map do |error|
        %(<span class="error-msg">#{error}</span>)
      end
  
      html = <<~EOM
      <div class="field_with_errors">
        #{html_tag}
        #{errors_tag.join}
      </div>
      EOM
      html.html_safe
    end
  end
