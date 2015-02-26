React = require('react')
jade = require('react-jade')
_ = require('lodash')

FluxComponent = require('flummox/component')

Board = require('./Board.coffee')
Room = require('./Room.coffee')

module.exports =
class Application extends React.Component
  render: =>
    jade.compile("""
      header.navbar.navbar-default.navbar-static-top
        .container
          .navbar-header
            a.navbar-brand(href="/") Reversi
      .container
        Room
        FluxComponent(flux=flux connectToStores=['board'])
          Board
    """)(_.assign(@, @props, @state))

