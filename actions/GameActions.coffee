Actions = require('flummox').Actions
socket = require('socket.io-client')()

module.exports =
class GameActions extends Actions
  startGame: ->
    null
  endGame: ->
    null
  giveupGame: ->
    null
  addPiece: (grid, player) ->
    grid.piece =
      player: player
    grid
