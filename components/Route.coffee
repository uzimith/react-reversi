React = require('react')
jade = require('react-jade')
_ = require('lodash')

FluxComponent = require('flummox/component')

module.exports =
class Route extends React.Component
  render: =>
    @isShow = @props["show"+@props.show]
    jade.compile("""
      if isShow
        div= children
    """)(_.assign(@, @props, @state))
