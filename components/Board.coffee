React = require('react')
jade = require('react-jade')
_ = require('lodash')

FluxComponent = require('flummox/component')

Grid = require('./Grid.coffee')
Piece = require('./Piece.coffee')

module.exports =
class Board extends React.Component
  render: =>
    jade.compile("""
      span player
      span= player
      table#board
        each rows in grids
          tr
            each col in rows
              td
                Grid(grid=col flux=flux)
    """)(_.assign(@, @props, @state))

