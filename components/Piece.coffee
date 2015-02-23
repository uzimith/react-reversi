React = require('react')
jade = require('react-jade')
_ = require('lodash')

module.exports =
class Piece extends React.Component
  render: =>
    jade.compile("""
    .piece= piece.color ? "■" : "□"
    """)(_.assign(@, @props, @state))
