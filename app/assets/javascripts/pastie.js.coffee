# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#new-pastie').click (e) ->
  e.preventDefault()
  location.href = '/pastie/new'
  false

$('#pastie-query').on 'submit', (e)->
  e.preventDefault()
  token = $('#pastie-token').val()
  location.href = '/pastie/' + token
  false

$('#clear-pastie').click (e) ->
  e.preventDefault()
  if confirm('Are you sure you want to clear this Pastie?')
    token = $('#current-token').val()
    location.href = '/pastie/clear/'+token

  false
