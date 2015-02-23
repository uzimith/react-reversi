React = require('react')
jade = require('react-jade')
_ = require('lodash')

module.exports =
class Piece extends React.Component
  @defaultProps =
    color: true
  constructor: ->
    console.log(@props)
    @state =
      color: true
  render: =>
    jade.compile("""
    span(onClick=onClick)= color ? "■" : "□"
    """)(_.assign(@, @props, @state))
  onClick: =>
    console.log(@state)
    @setState color: !@state.color

