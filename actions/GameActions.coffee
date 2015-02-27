Actions = require('flummox').Actions

module.exports =
class GameActions extends Actions
  startGame: (player)->
    player
  endGame: ->
    null
  giveupGame: (player)->
    player
  addPiece: (grid, player) ->
    grid.piece =
      player: player
    grid
