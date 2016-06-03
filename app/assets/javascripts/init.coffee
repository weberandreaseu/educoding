window.App ||= {}

App.init = ->
  console.log 'Init app'

$(document).on "page:change", ->
  App.init()
