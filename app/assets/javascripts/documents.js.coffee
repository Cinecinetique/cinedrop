# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $('#new_document').submit -> 
#   (@).preventDefault();
#   alert "hello world"
#   true
opts = {
  lines: 13, # The number of lines to draw
  length: 20, # The length of each line
  width: 10, # The line thickness
  radius: 30, # The radius of the inner circle
  corners: 1, # Corner roundness (0..1)
  rotate: 0, # The rotation offset
  direction: 1, # 1: clockwise, -1: counterclockwise
  color: '#000', # #rgb or #rrggbb
  speed: 1, # Rounds per second
  trail: 60, # Afterglow percentage
  shadow: false, # Whether to render a shadow
  hwaccel: false, # Whether to use hardware acceleration
  className: 'spinner', # The CSS class to assign to the spinner
  zIndex: 2e9, # The z-index (defaults to 2000000000)
  top: 'auto', # Top position relative to parent in px
  left: 'auto', # Left position relative to parent in px
  position: 'relative'
}

# $(document).on 'page:change', -> 
# 	console.log "page changed"
# 	spinner = new Spinner(opts).spin();	
# 	$(".new_document").on 'ajax:error', (e, xhr, status, error) ->
# 		$("#feedback").html "A problem has occured. Verify you've supplied all required parameters and try again."
# 		console.log xhr.responseText

# 	$("form").on 'submit', ->
# 		$("#feedback").html spinner.el



# 	$("form").on 'ajax:success', (e, data, status, xhr) ->
# 		console.log data
# 		spinner.stop()
# 		document.write(data);	

# @KeepAlive =
#   poll: ->
#     #console.log 'setting up Timeout'
#     setTimeout @request, 20000
  
#   request: ->
#     #console.log 'executing request'
#     $.ajax $('#feedback').data('url'),
#       type: 'GET'
#       dataType: 'script'
#       error: (jqXHR, textStatus, errorThrown) ->
#           console.log errorThrown
#           console.log "AJAX Error: #{textStatus}"
#       success: (data, textStatus, jqXHR) ->
#           console.log "."

    

# $(document).on 'page:load', -> 
#   console.log 'page loaded'
#   KeepAlive.poll()

