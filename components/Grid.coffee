React = require('react')
jade = require('react-jade')
_ = require('lodash')

Piece= require('./Piece.coffee')

module.exports =
class Grid extends React.Component
  render: =>
    cx = React.addons.classSet
    classes = cx {
      next: @props.grid.next
    }
    jade.compile("""
      .grid(class=classes onClick=onClick)
        - if(grid.piece)
          Piece(piece=grid.piece)
    """)(_.assign(@, @props, @state))
  onClick: =>
    if @props.grid.next
      player = @props.flux.getStore("board").state.player
      @props.flux.getActions("game").addPiece(@props.grid, player)
