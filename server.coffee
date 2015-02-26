express = require('express')
app = express()
http = require('http').Server(app)
io = require('socket.io')(http)
port = 3000
app.use express.static('.')

io.on 'connection', (socket) ->
  console.log('a user connected')
  socket.on 'join', (name) ->
    console.log("join : " + name)
    socket.game_room = name
    socket.join(name)
  socket.on 'leave', (name) ->
    socket.leave(name)
  socket.on 'action', (data) ->
    console.log("action")
    console.log(socket.rooms)
    console.log(data)
    socket.to(socket.game_room).broadcast.emit('action', data)

http.listen port, ->
  console.log "listening on *:", port
