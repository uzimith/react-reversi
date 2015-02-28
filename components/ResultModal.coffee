React = require('react')
jade = require('react-jade')
_ = require('lodash')

module.exports =
class ResultModal extends React.Component
  render: =>
    cx = React.addons.classSet

    classes = cx {
      in: @props.showResult
      show: @props.showResult
    }

    player_class =
      1: cx({ player1: true, low: @props.scores[1] < 10, middle: @props.scores[1] in [10..30], high: @props.scores[1] > 30})
      2: cx({ player2: true, low: @props.scores[2] < 10, middle: @props.scores[2] in [10..30], high: @props.scores[2] > 30})

    jade.compile("""
      .modal.fade(class=classes)
        .modal-dialog
          .modal-content
            .modal-header
              button.close(onClick=onClick)
                span &times;
              h4.modal-title Result
            .modal-body
              table.table.table-bordered.back
                thead
                  tr
                    th #
                    th Score
                tbody
                  each score,player in scores
                    tr(class=player_class[player] key=player)
                      td.player= "player " + player
                      td.score= score
            .modal-footer
              h4.winner
                if player === 0
                  span Draw
                else
                  span Winner : 
                  span.result(class=player_class[winner])= "Player " + winner

    """)(_.assign(@, @props, @state))

  onClick: =>
    @props.flux.getActions("panel").hideResult()
