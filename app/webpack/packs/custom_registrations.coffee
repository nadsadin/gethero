import '../stylesheets/_smartwizard.scss'
window.jQuery = $
require('smartwizard')
require('jquery-validation')
getCompanyInfo = (inn_ogrn) ->
  inn_ogrn = new Number(inn_ogrn)
  company_info_container = $('#company_info')
  if !isNaN(inn_ogrn) && inn_ogrn>0
    url = "https://suggestions.dadata.ru/suggestions/api/4_1/rs/findById/party"
    $.ajax(
      type: "POST"
      url: url
      data: JSON.stringify({"query": inn_ogrn, "branch_type": "MAIN"})
      contentType: "application/json"
      headers:{
        Accept: "application/json"
        Authorization: "Token 64137fae228ddb4a5e2ab02b21099871a8746c1d"
      }
    ).done((data) ->
      if(data.suggestions.length>0)
        company_data = data.suggestions[0].data
        company = {title: {value: company_data.name.short_with_opf, label: 'Название'}}
        company.legal_address = {value: company_data.address.unrestricted_value, label: 'Юридический адрес'}
        if(company_data.inn)
          company.inn = {value: company_data.inn, label: 'ИНН'}
        if(company_data.ogrn)
          company.ogrn = {value: company_data.ogrn, label: 'ОГРН'}
        if(company_data.kpp)
          company.kpp = {value: company_data.kpp, label: 'КПП'}
        if(company_data.management)
          company.ceo = {value: company_data.management.name, label: 'Генеральный директор'}
        company_info_container.html('')
        $.each company, (key, field) ->
          company_info_container.append("<input type='hidden' name='custom_registration[#{key}]' id='custom_registration_#{key}' value='#{field.value}'>")
          company_info_container.append("<div class='text-muted mdc-my-2'><strong>#{field.label}</strong>: #{field.value}</div>")
      else
        company_info_container.html('')
        company_info_container.append("<div class='text-danger mdc-my-2'>Не найдена компания с такими данными</div><input type='checkbox' class='hidden' required='required' aria-required='true'>")
    ).fail(()->
      company_info_container.append("<div class='text-danger mdc-my-2'>Что-то пошло не так. Попробуйте повторить позже.</div><input type='checkbox' class='hidden' required='required' aria-required='true'>")
    )
  else
    company_info_container.append("<div class='text-danger mdc-my-2'>Неверные данные</div><input type='checkbox' class='hidden' required='required' aria-required='true'>")
$(document).on 'change', '#custom_registration_inn_ogrn', ()->
  window.company_info_updated = false
$(document).on 'click', '.sw-btn-next', ()->
  if !window.company_info_updated && $('#custom_registration_inn_ogrn').val()!=""
    getCompanyInfo($('#custom_registration_inn_ogrn').val())
    window.company_info_updated = true
document.addEventListener 'turbolinks:load', ()->
  $ = window.jQuery
  $form = $('.smart_wizard_form')
  $btnFinish = $('<button class="btn-finish mdc-button mdc-button--raised hidden mdc-ml-2" type="button">Сохранить</button>')
  # Set up validator
  $form.validate
    errorPlacement: (error, element) ->
      $(element).parents('.form-group').append error.addClass('invalid-feedback small d-block')
      return
    highlight: (element) ->
      $(element).parent().addClass 'mdc-text-field--invalid'
      return
    unhighlight: (element) ->
      $(element).parent().removeClass 'mdc-text-field--invalid'
      return
    rules: 'wizard-confirm': equalTo: 'input[name="wizard-password"]'
  # Initialize wizard
  $form.smartWizard(
    autoAdjustHeight: false
    backButtonSupport: false
    useURLhash: false
    anchorSettings:
      removeDoneStepOnNavigateBack: true
    lang:
      next: 'Далее'
      previous: 'Назад'
    showStepURLhash: false
    toolbarSettings: toolbarExtraButtons: [ $btnFinish ]).on('leaveStep', (e, anchorObject, stepNumber, stepDirection) ->
# stepDirection === 'forward' :- this condition allows to do the form validation
# only on forward navigation, that makes easy navigation on backwards still do the validation when going next
    if stepDirection == 'forward'
      return $form.valid()
    true
  ).on 'showStep', (e, anchorObject, stepNumber, stepDirection) ->
    $btn = $form.find('.btn-finish')
    # Enable finish button only on last step
    if stepNumber == $('.step-anchor li').length-1
      $btn.removeClass 'hidden'
    else
      $btn.addClass 'hidden'
    return
  # Click on finish button
  $form.find('.btn-finish').on 'click', ->
    if !$form.valid()
      return
    # Submit form
    $form.submit()
    false
  $(document).on 'submit', '.simple_form', ->
    $(this).validate
      errorPlacement: (error, element) ->
        $(element).parents('.form-group').append error.addClass('invalid-feedback small d-block')
        return
      highlight: (element) ->
        $(element).parent().addClass 'mdc-text-field--invalid'
        return
      unhighlight: (element) ->
        $(element).parent().removeClass 'mdc-text-field--invalid'
        return
    if !$(this).valid()
      enable = () ->
        $('input[type="submit"]').prop('disabled', false)
      setTimeout(enable, 1000)
      return false
    # Submit form
    $form.submit()
  # Realtime location preview update
  $('#custom_registration_location_title').keyup (e) ->
    $('#location_title').text($(this).val())
  $('#custom_registration_short_description').keyup (e) ->
    $('#location_description').text($(this).val())
  $('#custom_registration_address').keyup (e) ->
    $('#location_address').text($(this).val())
  $('#custom_registration_phone').keyup (e) ->
    $('#location_phone').text($(this).val())
  $('#custom_registration_website').keyup (e) ->
    $('#location_website').text($(this).val())
  $('#custom_registration_category_id').change (e) ->
    $('#location_category').text($(this).find(':selected').text())
  $('#custom_registration_logo').change (e) ->
    input = this
    if input.files and input.files[0]
      photo_reader = new FileReader
      photo_reader.onloadend = (e) ->
        $('#location_logo').css('background-image', 'url('+photo_reader.result+')')
      photo_reader.readAsDataURL input.files[0]
  $('#custom_registration_preview').change (e) ->
    input = this
    if input.files and input.files[0]
      photo_reader = new FileReader
      photo_reader.onloadend = (e) ->
        $('#location_bg').css('background-image', 'url('+photo_reader.result+')')
      photo_reader.readAsDataURL input.files[0]

  if $('#quill-editor').length > 0
    form = $('.quill-form')
    $(document).on 'submit', form, (e) ->
      input = $('#quill-editor').siblings('input')[0]
      input.value = window.editor.root.innerHTML