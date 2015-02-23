Actions = require('flummox').Actions

module.exports =
class GameActions extends Actions
  addPiece: (grid) ->
    grid.piece =
      color: true # TODO: depends player
    grid
