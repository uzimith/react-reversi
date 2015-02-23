React = require('react')
Store = require('flummox').Store
_ = require('lodash')


module.exports =
class BoardStore extends Store
  constructor: (flux) ->
    super
    gameActions = flux.getActionIds('game')
    @register(gameActions.addPiece, @handleNewPiece)
    @state = {}
    num = 9
    @state.grids = _.map [0..num], (row)->
      _.map [0..num], (col)->
        piece = null
        if (row is 4 and col is 4) or (row is 5 and col is 5)
          piece = {color: true}
        if (row is 4 and col is 5) or (row is 5 and col is 4)
          piece = {color: false}
        {row: row, col: col, piece: piece}
  handleNewPiece: (grid)->
    grids = @state.grids
    grids[grid.row][grid.col] = grid
    @setState grids: grids
