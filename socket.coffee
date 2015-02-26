module.exports = (flux) ->
  socket.on 'connect', ->
    console.log("connect")
  socket.on 'action', (data) ->
    console.log("action")
    flux.getActions("game")[data['action']].apply(@, data['args'])
  socket.on 'disconnect', ->
    console.log("disconnect")
