module ApplicationHelper

  def menu_link(text, path, controller, actions=['index','show','new','edit'])
    link_to(content_tag(:span, text, class: 'mdc-list-item__text'), path, class: "mdc-list-item ")
  end


  def present(model, klass = nil)
    return if model.blank?
    klass ||= "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?
    presenter
  end

  def rating_stars(rating, html_class = '')
    filled = rating.floor
    half_filled = (rating-filled).round
    none_filled = 5-filled-half_filled
    result = "<div class='ui-stars #{html_class}'>"
    filled.times do
      result += '<div class="ui-star filled">
                  <i class="material-icons">star</i>
                  <i class="material-icons">star</i>
                </div>'
    end
    half_filled.times do
      result += '<div class="ui-star half-filled">
                  <i class="material-icons">star</i>
                  <i class="material-icons">star</i>
                </div>'
    end
    none_filled.times do
      result += '<div class="ui-star">
                  <i class="material-icons">star</i>
                  <i class="material-icons">star</i>
                </div>'
    end
    result += '</div>'
    result.html_safe
  end

  def material_select(field_name, label, collection, value_method, text_method, selected = nil, required = false, helper_line = nil, error_line = 'Внимание! Вы не заполнили обязательное поле!')
    result = "<div class='mdc-field-container'><div class='mdc-select mdc-select--outlined #{'mdc-select--required' if required}' data-mdc-auto-init='MDCSelect'>
              <input type='hidden' name='#{field_name}' value='#{selected}' class='my_mdc-select__value' />
              <div class='mdc-select__anchor w-100'>
                <i class='mdc-select__dropdown-icon'></i>
                <div class='mdc-select__selected-text' aria-labelledby='outlined-select-label' aria-required='true'>
                  #{collection.detect{|i| i.send(value_method) == selected}.send(text_method) if selected}</div>
                <div class='mdc-notched-outline'>
                  <div class='mdc-notched-outline__leading'></div>
                  <div class='mdc-notched-outline__notch'>
                    <span class='mdc-floating-label'>#{label}</span>
                  </div>
                  <div class='mdc-notched-outline__trailing'></div>
                </div>
              </div>

              <!-- Other elements from the select remain. -->
              <div class='mdc-select__menu mdc-menu mdc-menu-surface w-100' role='listbox'>
                <ul class='mdc-list'>"
    collection.each do |item|
      result+="<li class='mdc-list-item #{'mdc-list-item--selected' if item.send(value_method)==selected}' data-value='#{item.send(value_method)}' role='option' >
                    #{item.send(text_method)}
                  </li>"
    end

    result+="</ul>
              </div>
            </div>"
    result+="<div class='mdc-text-field-helper-line '>
              <div class='mdc-text-field-helper-text mdc-text-field-helper-text--persistent '  aria-hidden='true'>#{helper_line}</div>
            </div>" if helper_line
    result+="<div class='mdc-text-field-helper-line mdc-text-field-helper-line--error'>
              <div class='mdc-text-field-helper-text mdc-text-field-helper-text--error '  aria-hidden='true'>#{error_line}</div>
            </div>"
    result+='</div>'
    result.html_safe
  end

   def backlink
     request.referer.present? ? request.referer : @back_default
   end

  # Returns the i18n version the models current enum key
  # Example usage:
  # enum_l(user, :approval_state)
  def enum_l(model, enum)
    enum_i18n(model.class, enum, model.send(enum))
  end

  # Returns the i18n string for the enum key
  # Example usage:
  # enum_i18n(User, :approval_state, :unprocessed)
  def enum_i18n(class_name, enum, key)
    I18n.t("activerecord.enums.#{class_name.model_name.i18n_key}.#{enum.to_s.pluralize}.#{key}")
  end
end
