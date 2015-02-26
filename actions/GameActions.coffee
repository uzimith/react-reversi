Actions = require('flummox').Actions
socket = require('socket.io-client')()

module.exports =
class GameActions extends Actions
  startGame: (player)->
    player
  endGame: ->
    null
  giveupGame: ->
    null
  addPiece: (grid, player) ->
    grid.piece =
      player: player
    grid
