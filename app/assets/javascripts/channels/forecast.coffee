App.forecast = App.cable.subscriptions.create "ForecastChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data)
    $('.forecasts').empty()
    $(".forecasts").append(data['message'])
