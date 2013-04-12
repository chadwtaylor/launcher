$ ->

  $('form[data-remote] .button.submit').click ->
    submit_button_clicked($(this))

  $('.flexslider').flexslider({
    animation:'slide',
    controlNav: false,
    directionNav: false,
    pauseOnHover: true,
    slideshowSpeed: 5000
  })

  $('.rollover .figure')
    .mouseover -> $(this).addClass('next')
    .mouseout -> $(this).removeClass('next')

  # ------------------------------------------------------------------------------------------------------------
  # HOVERING STUFF
  # ------------------------------------------------------------------------------------------------------------
  $('nav .link, aside .link, aside .topic, .sizes .size')
    .mouseover -> $(this).addClass('hovered')
    .mouseout -> $(this).removeClass('hovered')

  # ------------------------------------------------------------------------------------------------------------
  # TABS STUFF
  # ------------------------------------------------------------------------------------------------------------
  $('a[data-tab] .tab').removeClass('selected')
  current_tab = $('body').data('tab')
  $('a[data-tab="' + current_tab + '"] .tab').addClass('selected')

  # ------------------------------------------------------------------------------------------------------------
  # TSHIRT STUFF
  # ------------------------------------------------------------------------------------------------------------
  $('.gender .size')
    .click (e) ->
      e.stopPropagation()
      e.preventDefault()
      $('#tshirt_size').val($(this).data('size'))
      $(this).parents('form').submit()

  # ------------------------------------------------------------------------------------------------------------
  # REWARD STUFF
  # ------------------------------------------------------------------------------------------------------------
  $('.reward_group .reward[data-disabled=false]')
    .mouseover -> $(this).addClass('hovered')
    .mouseout -> $(this).removeClass('hovered')

  $('.reward[data-reward-id]')
    .click (e) ->
      e.stopPropagation()
      e.preventDefault()
      return if $(this).data('disabled') == true
      rid = $(this).data('reward-id')
      summary = $(this).data('reward-summary')
      subject = $(this).data('reward-subject')
      amount = $(this).data('reward-amount')
      $('#reward_id_' + rid).attr('checked', true)
      $('#reward_subject').val(subject)
      $('#reward_summary').val(summary)
      $('#reward_amount').val(amount)
      $(this).parent('form').submit()

  # ------------------------------------------------------------------------------------------------------------
  # FLASH MESSAGES
  # ------------------------------------------------------------------------------------------------------------
  $(document).ajaxComplete (event, request) ->

    $('form[data-remote] .button.submit').fadeTo(100, 1).click ->
      submit_button_clicked($(this))

    message = $.parseJSON(request.getResponseHeader('X-Flash-Messages'));
    flash(message)

  # ------------------------------------------------------------------------------------------------------------
  # TRACKING STUFF
  # ------------------------------------------------------------------------------------------------------------
  $("[href*='.zip'][data-track]").click (e) ->
    data = {}
    data.url = $(this).attr('href')
    data.description = $(this).data('description')
    track_download(data)


jQuery.fn.clear_form = ->
  $(this).find(":input").each ->
    switch this.type
      when 'password', 'select-multiple', 'select-one', 'text', 'textarea'
        $(this).val('')
      when 'checkbox', 'radio'
        $(this).attr('checked', false) unless $(this).is(':disabled')

jQuery.fn.is_blank = ->
  return $(this).val() == ""


window.submit_button_clicked = (btn) ->
  $(btn).unbind('click')
  $(btn).fadeTo(100, .25)
  $(btn).parents('form').submit()

# ------------------------------------------------------------------------------------------------------------
# FLASH METHODS
# ------------------------------------------------------------------------------------------------------------
window.flash_message = (msg, type='error') ->
  message = {}
  message[type] = msg
  flash(message)

window.flash = (message) ->
  flash_reset()
  return unless message

  if message.error
    $('.flash').append('<div class="error">' + message.error + "</div>")
  if message.notice
    $('.flash').append('<div class="notice">' + message.notice + "</div>")

window.flash_reset = ->
  $('.flash .error, .flash .notice').remove('.error').remove('.notice')
  $('input.error').removeClass('error')

# ------------------------------------------------------------------------------------------------------------
# ANALYITCS TRACKING
# ------------------------------------------------------------------------------------------------------------
window.track_event = (event, data) ->
  try
    data.name = event
    woopraTracker.pushEvent(data)
    woopraTracker.track()
  catch error
    # do nothing
  try
    GoSquared.DefaultTracker.TrackEvent(event, data)
  catch error
    # do nothing

window.track_visitor_data = (key, value) ->
  try
    woopraTracker.addVisitorProperty(key, value)
    woopraTracker.track()
  catch error
    # do nothing

  try
    if key=='email' || key=='name'
      GoSquared.UserName = value
    else
      GoSquared.Visitor = value
  catch error
    # do nothing

window.track_download = (data) ->
  setTimeout track_download_submit(data), 500

window.track_download_submit = (data) ->
  try
    data.name = "download"
    woopraTracker.pushEvent(data)
    woopraTracker.track()
  catch error
    # do nothing

  try
    GoSquared.DefaultTracker.TrackEvent("download", data)
  catch error
    # do nothing
