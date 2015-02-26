express = require('express')
app = express()
http = require('http').Server(app)
io = require('socket.io')(http)
port = 3000
app.use express.static('.')

io.on 'connection', (socket) ->
  console.log('a user connected')
  socket.on 'action', (data) ->
    console.log("action")
    console.log(data)
    socket.broadcast.emit('action', data)

http.listen port, ->
  console.log "listening on *:", port
