React = require('react')
Store = require('flummox').Store
_ = require('lodash')

module.exports =
class PanelActions extends Store
  constructor: (flux) ->
    super
    panelActions = flux.getActionIds('panel')
    @register(panelActions.joinBoard, @joinBoard)
    @register(panelActions.createBoard, @createBoard)
    @state =
      showBoard: false
      showRoom: true

  createBoard: ->
    @setState {
      showBoard: false
      showRoom: false
    }
    socket.on 'join', =>
      @setState {
        showBoard: true
        showRoom: false
      }
  joinBoard: ->
    @setState {
      showBoard: false
      showRoom: false
    }
    socket.on 'join', =>
      @setState {
        showBoard: true
        showRoom: false
      }
