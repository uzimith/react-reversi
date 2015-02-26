React = require('react')
jade = require('react-jade')
_ = require('lodash')

module.exports =
class Piece extends React.Component
  render: =>
    jade.compile("""
    .piece= piece.player === 1 ? "■" : "□"
    """)(_.assign(@, @props, @state))
