express = require('express')
app = express()
http = require('http').Server(app)
io = require('socket.io')(http)
port = process.env.PORT || 3000
app.use express.static('.')

_ = require('lodash')

io.on 'connection', (socket) ->
  console.log('a user connected')

  socket.on 'create', ->
    loop
      name = (Math.floor(Math.random() * 10) for _ in [0...5]).join("")
      break unless name in Object.keys(io.sockets.adapter.rooms)
    console.log("create : " + name)
    socket.game_room = name
    socket.join(name)
    socket.emit('join', name)

  socket.on 'join', (name) ->
    console.log("join : " + name)
    socket.game_room = name
    socket.join(name)
    console.log(io.sockets.adapter.rooms)
    socket.emit('join', name)

  socket.on 'leave', (name) ->
    socket.leave(name)

  socket.on 'action', (data) ->
    console.log("action")
    console.log(data)
    socket.to(socket.game_room).broadcast.emit('action', data)

http.listen port, ->
  console.log "listening on *:", port
