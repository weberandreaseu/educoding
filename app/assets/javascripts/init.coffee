window.App ||= {}

App.init = ->
  console.log 'Init app'
  $('[data-toggle="tooltip"]').tooltip()

$(document).on "turbolinks:load", ->
  App.init()