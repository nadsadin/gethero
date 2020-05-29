SimpleForm.setup do |config|
  config.wrappers :mdc_text, tag: 'div', class: 'mdc-field-container mdc-input__fullwidth', error_class: 'mdc-text-field--invalid' do |mdc|
    mdc.wrapper tag: 'div', html: {data: {'mdc-auto-init' => 'MDCTextField'}} , class: 'mdc-text-field mdc-text-field--outlined', error_class: 'mdc-text-field--invalid' do |mdc|
      mdc.use :html5
      mdc.optional :maxlength
      mdc.optional :minlength
      mdc.optional :pattern
      mdc.optional :min_max
      mdc.optional :readonly
      mdc.use :input, class: "mdc-text-field__input", error_class: 'mdc-text-field--invalid'
      mdc.wrapper tag: 'div', class: 'mdc-notched-outline' do |notch|
        notch.wrapper(tag: 'div', class: 'mdc-notched-outline__leading'){}
        notch.wrapper tag: 'div', class: 'mdc-notched-outline__notch' do |l|
          l.use :label, class: 'mdc-floating-label'
        end
        notch.wrapper(tag: 'div', class: 'mdc-notched-outline__trailing'){}
      end
    end
    mdc.wrapper tag: 'div', class: 'mdc-text-field-helper-line' do |helper|
      helper.use :hint, wrap_with: {tag: 'div', class: 'mdc-text-field-helper-text mdc-text-field-helper-text--persistent'}
      helper.use :error, wrap_with: {tag: 'div', class: 'mdc-text-field-helper-text mdc-text-field-helper-text--persistent mdc-text-field-helper-text--validation-msg', html: {role: 'alert'}}
    end
  end
  config.wrappers :mdc_textarea, tag: 'div', class: 'mdc-field-container mdc-input__fullwidth', error_class: 'mdc-text-field--invalid' do |mdc|
    mdc.wrapper tag: 'div', html: {data: {'mdc-auto-init' => 'MDCTextField'}} , class: 'mdc-text-field mdc-text-field--textarea', error_class: 'mdc-text-field--invalid' do |mdc|
      mdc.use :html5
      mdc.optional :maxlength
      mdc.optional :minlength
      mdc.optional :pattern
      mdc.optional :min_max
      mdc.optional :readonly
      mdc.use :input, class: "mdc-text-field__input", error_class: 'mdc-text-field--invalid'
      mdc.wrapper tag: 'div', class: 'mdc-notched-outline' do |notch|
        notch.wrapper(tag: 'div', class: 'mdc-notched-outline__leading'){}
        notch.wrapper tag: 'div', class: 'mdc-notched-outline__notch' do |l|
          l.use :label, class: 'mdc-floating-label'
        end
        notch.wrapper(tag: 'div', class: 'mdc-notched-outline__trailing'){}
      end
    end
    mdc.wrapper tag: 'div', class: 'mdc-text-field-helper-line' do |helper|
      helper.use :hint, wrap_with: {tag: 'div', class: 'mdc-text-field-helper-text mdc-text-field-helper-text--persistent'}
      helper.use :error, wrap_with: {tag: 'div', class: 'mdc-text-field-helper-text mdc-text-field-helper-text--persistent mdc-text-field-helper-text--validation-msg', html: {role: 'alert'}}
    end
  end
  config.wrappers :mdc_select, tag: 'div', class: 'mdc-field-container mdc-input__fullwidth', error_class: 'mdc-select--invalid' do |mdc|
    mdc.wrapper tag: 'div', html: {data: {'mdc-auto-init' => 'MDCSelect'}} , class: 'mdc-select mdc-select--outlined', error_class: 'mdc-select--invalid' do |mdc|
      mdc.wrapper tag: 'div', class: 'mdc-select__anchor' do |mdc|
        mdc.use :html5
        mdc.optional :maxlength
        mdc.optional :minlength
        mdc.optional :pattern
        mdc.optional :min_max
        mdc.optional :readonly
        mdc.wrapper(tag: 'i', class: 'mdc-select__dropdown-icon'){}
        mdc.wrapper(tag: 'div', class: 'mdc-select__selected-text'){}
        mdc.use :input, class: "mdc-select__native-control", error_class: 'mdc-select--invalid'
        mdc.wrapper tag: 'div', class: 'mdc-notched-outline' do |notch|
          notch.wrapper(tag: 'div', class: 'mdc-notched-outline__leading'){}
          notch.wrapper tag: 'div', class: 'mdc-notched-outline__notch' do |l|
            l.use :label, class: 'mdc-floating-label'
          end
          notch.wrapper(tag: 'div', class: 'mdc-notched-outline__trailing'){}
        end
      end
    end
    mdc.wrapper tag: 'div', class: 'mdc-text-field-helper-line' do |helper|
      helper.use :hint, wrap_with: {tag: 'div', class: 'mdc-text-field-helper-text mdc-text-field-helper-text--persistent'}
      helper.use :error, wrap_with: {tag: 'div', class: 'mdc-text-field-helper-text mdc-text-field-helper-text--persistent mdc-text-field-helper-text--validation-msg', html: {role: 'alert'}}
    end
  end
  config.wrapper_mappings = {
      string: :mdc_text,
      email: :mdc_text,
      password: :mdc_text,
      tel: :mdc_text,
      integer: :mdc_text,
      text: :mdc_textarea,
      #select: :mdc_select,
  }
end