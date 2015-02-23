React = require('react')
jade = require('react-jade')
_ = require('lodash')

Grid = require('./Grid.coffee')
Piece = require('./Piece.coffee')

module.exports =
class Board extends React.Component
  num = 9
  grid = _.map [1..num], (row)->
    React.createElement("tr", {key: row},
      _.map [1..num], (col)->
        component = null
        if (row is 4 and col is 4) or (row is 5 and col is 5)
          component = React.createFactory(Piece)({color: true})
        if (row is 4 and col is 5) or (row is 5 and col is 4)
          component = React.createFactory(Piece)({color: false})
        console.log(component)
        jade.compile("""
        td(key=col)
          Grid(component=component)
        """)(component: component, col: col)
    )
  render: =>
    jade.compile("""
      table#board= grid
    """)(_.assign(@, @props, @state))

