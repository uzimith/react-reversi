React = require('react')
jade = require('react-jade')
_ = require('lodash')

FluxComponent = require('flummox/component')

Grid = require('./Grid.coffee')
Piece = require('./Piece.coffee')

module.exports =
class Board extends React.Component
  render: =>
    cx = React.addons.classSet
    player_class =
      1: cx({ player1: true, low: @props.scores[1] < 10, middle: @props.scores[1] in [10..30], high: @props.scores[1] > 30})
      2: cx({ player2: true, low: @props.scores[2] < 10, middle: @props.scores[2] in [10..30], high: @props.scores[2] > 30})
    start_classes  = cx show: !@props.play, hide:  @props.play
    giveup_classes = cx show:  @props.play, hide: !@props.play
    end_classes    = cx show:  @props.end, hide: !@props.end

    jade.compile("""
      .row
        .col-md-2.col-md-offset-2
          .row
            a.control.btn.btn-default(class=start_classes onClick=startGame) Start
            a.control.btn.btn-default(class=giveup_classes onClick=giveupGame) Give up
            a.control.btn.btn-default(class=end_classes onClick=endGame) End

          hr

          table.table.table-bordered.back
            tbody
              tr
                th Room
                td= roomId
              tr(class=player_class[player])
                th Current
                td= player

          table.table.table-bordered.back
            thead
              tr
                th #
                th Score
            tbody
              each score,player in scores
                tr(class=player_class[player] key=index)
                  td.player= "player " + player
                  td.score= score

        .col-md-8
          #board
            each rows,index in grids
              .clearfix(key=index)
                each col,index in rows
                  .col(key=index)
                    Grid(grid=col flux=flux)
    """)(_.assign(@, @props, @state))
  startGame: =>
    socket.push('action', action: "startGame", args: [2])
  giveupGame: =>
    player = @props.flux.getStore("board").state.player
    socket.push('action', action: "giveupGame", args: [player])
  endGame: =>
    socket.push('action', action: "endGame", args: [])
