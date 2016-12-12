# freeze_string_literals: true

module BootstrapHelper
  def close_button
    content_tag(:button,
                content_tag(:span, '&times;', { aria: { hidden: 'true' } }, false),
                class: 'close',
                type: 'button',
                data: { dismiss: 'alert' },
                aria: { label: 'Close' })
  end
end
