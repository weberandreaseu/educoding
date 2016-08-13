window.App ||= {}

App.init = ->
  console.log 'Init app'

$(document).on "turbolinks:load", ->
  App.init()