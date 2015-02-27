React = require('react')
Store = require('flummox').Store
_ = require('lodash')

module.exports =
class PanelActions extends Store
  constructor: (flux) ->
    super
    panelActions = flux.getActionIds('panel')
    @register(panelActions.moveToBoard, @moveToBoard)
    @state =
      showBoard: false
      showRoom: true

  moveToBoard: ->
    @setState {
      showBoard: false
      showRoom: false
    }
    socket.on 'join', =>
      @setState {
        showBoard: true
        showRoom: false
      }
