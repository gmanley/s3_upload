THUMB_TYPES =
  'Huge':         'huge'
  'Large':        'large'
  'Medium':       'medium'
  'Small':        'small'
  'Large Square': 'large_square'
  'Small Square': 'small_square'

# TODO: Refactor... I'm probably overcomplicating this :\
thumbnailsForImage = (image_uri) ->
  thumbnails = {'Original': image_uri}
  uri_arry = image_uri.split('/')
  image_file_name = uri_arry.pop()
  _(THUMB_TYPES).each (type, label) ->
    thumbnail_arry = _(uri_arry).clone()
    thumbnail_arry.push("#{type}_#{image_file_name}")
    thumbnails[label] = thumbnail_arry.join('/')
    thumbnail_arry
  thumbnails

initClippy = (opts) ->
  $('#copy-url').clippy
    clippy_path: "/assets/clippy.swf"
    text: opts.text
$ ->
  $('#start_upload').button()

  uploader = new plupload.Uploader(
    runtimes: 'html5,flash'
    browse_button: 'select_files'
    max_file_size: '10mb'
    url: "#{window.location.pathname}/images.js"
    file_data_name: 'image[image]'
    flash_swf_url: '/assets/plupload.flash.swf'
    drop_element: 'content'
    filters:
      {title: 'Image files', extensions: 'jpg,jpeg,gif,png'}
    multipart: true
    multipart_params:
      authenticity_token: authenticity_token
      _s3_upload_session: session_token
    )

  uploader.bind "FilesAdded", (up, files) ->
    $.each files, (i, file) ->
      $("#file_list").append(JST['templates/file'](file: file))

  uploader.bind 'UploadProgress', (up, file) ->
    $("##{file.id} b").html("#{file.percent}%")
    $("##{file.id} .progress .bar").css('width', "#{file.percent}%")

  $('#start_upload').click (e) ->
    uploader.start()
    $(this).button('loading')
    e.preventDefault()

  uploader.bind 'FileUploaded', (up, file, request) ->
    image = JSON.parse(request.response)
    $(".thumbnails").append(JST['templates/image'](image: image))
    $("##{file.id} .progress")
      .toggleClass('active')
      .prev('.file_info b').text('Done')
      .fadeOut 'slow', ->
        $(this).parent().css('border', 'none')

  uploader.bind 'UploadComplete', (up, files) ->
    $('#start_upload').button('complete')

  uploader.init()

  $modal = $('#modal-gallery')
  $(document.body).on 'image_loaded.modal-gallery', (e) ->
    image_uri = $modal.find('.modal-image img.in').first().attr('src')
    $modal.find('#image_url').val(image_uri)
    $select = $('#thumbnail_select')
    _(thumbnailsForImage(image_uri)).each (url, label) ->
      $select.append $("<option />").val(url).text(label)
    $select.on 'change', (e) ->
      image_uri = $(this).val()
      $('#image_url').val(image_uri)
      $('#copy-url').data('text', image_uri)
      initClippy(text: image_uri)
    initClippy(text: image_uri)

