Actions = require('flummox').Actions

module.exports =
class GameActions extends Actions
  addPiece: (grid, player) ->
    grid.piece =
      player: player
    grid
