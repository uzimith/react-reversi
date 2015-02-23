React = require('react')
jade = require('react-jade')
_ = require('lodash')

FluxComponent = require('flummox/component')

Board = require('./Board.coffee')

module.exports =
class Application extends React.Component
  render: =>
    jade.compile("""
      h1 リバーシ
      Board
    """)(_.assign(@, @props, @state))

