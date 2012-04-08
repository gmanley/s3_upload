$ ->
  $('.page-header h3').editable window.location.pathname,
    method: 'PUT'
    indicator: 'Saving...'
    tooltip: 'Click to edit...'
    ajaxoptions:
      dataType: 'json'
    submitdata: (value, settings) ->
      authenticity_token: authenticity_token
      _s3_upload_session: session_token
      album:
        title: value

  $('li.active a, li.disabled a').on('click', false)