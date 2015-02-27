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
      .row
        .col-md-2.col-md-offset-2
          .row
            a.btn.btn-default(onClick=startGame) Start
            a.btn.btn-default(onClick=endGame) Give up
          h5 Current
          span player 
          span= player
          h5 Score
          each score,player in scores
            p= "player " + player + ": " + score
        .col-md-8
          #board
            each rows in grids
              .clearfix
                each col in rows
                  .col
                    Grid(grid=col flux=flux)
    """)(_.assign(@, @props, @state))
  startGame: =>
    socket.emit('action', action: "startGame", args: [2])
    @props.flux.getActions("game").startGame(2)
