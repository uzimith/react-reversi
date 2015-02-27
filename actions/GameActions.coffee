Actions = require('flummox').Actions

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
