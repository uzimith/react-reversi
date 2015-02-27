React = require('react')
jade = require('react-jade')
_ = require('lodash')

module.exports =
class Piece extends React.Component
  render: =>
    cx = React.addons.classSet
    classes = cx {
      piece1: @props.piece.player is 1,
      piece2: @props.piece.player is 2,
    }
    jade.compile("""
    .piece(class=classes)
    """)(_.assign(@, @props, @state))
