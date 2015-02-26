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
      h5 Current
      span player 
      span= player
      table#board
        each rows in grids
          tr
            each col in rows
              td
                Grid(grid=col flux=flux)
      h5 Score
      each score,player in scores
        p= "player " + player + ": " + score
      h5 Control
      .row
        a.btn.btn-default(onClick=startGame) Start
        a.btn.btn-default(onClick=endGame) Give up
    """)(_.assign(@, @props, @state))
  startGame: =>
    socket.emit('action', action: "startGame", args: null)
    @props.flux.getActions("game").startGame()
