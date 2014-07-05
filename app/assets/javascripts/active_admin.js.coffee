#= require active_admin/base

sendSortRequestOfModel = (model_name) ->
  formData = $('#index_table_' + model_name + ' tbody').sortable('serialize')
  formData += "&" + $('meta[name=csrf-param]').attr("content") + "=" + encodeURIComponent($('meta[name=csrf-token]').attr("content"))
  $.ajax
    type: 'post'
    data: formData
    dataType: 'script'
    url: '/admin/' + model_name + '/sort'

jQuery ($) ->
  # Projects index
  if $('body.admin_projects.index').length
    $("#index_table_projects tbody").disableSelection().sortable
      axis: 'y'
      cursor: 'move'
      update: (event, ui) ->
        sendSortRequestOfModel("projects")

  # Categories Index
  if $('body.admin_categories.index').length
    $("#index_table_categories tbody").disableSelection().sortable
      axis: 'y'
      cursor: 'move'
      update: (event, ui) ->
        sendSortRequestOfModel("categories")

