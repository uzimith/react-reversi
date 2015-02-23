React = require('react')
jade = require('react-jade')
_ = require('lodash')

Piece= require('./Piece.coffee')

module.exports =
class Grid extends React.Component
  render: =>
    jade.compile("""
      .grid(onClick=onClick)
        - if(grid.piece)
          Piece(piece=grid.piece)
    """)(_.assign(@, @props, @state))
  onClick: =>
    unless @props.piece
      @props.flux.getActions("game").addPiece(@props.grid)
