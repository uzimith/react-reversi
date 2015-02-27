React = require('react')
Store = require('flummox').Store
_ = require('lodash')

module.exports =
class PanelActions extends Store
  constructor: (flux) ->
    super
    panelActions = flux.getActionIds('panel')
    gameActions = flux.getActionIds('game')
    @register(panelActions.joinBoard, @joinBoard)
    @register(panelActions.createBoard, @createBoard)
    @register(panelActions.hideResult, @hideResultModal)
    @register(gameActions.giveupGame, @showResultModal)
    @register(gameActions.endGame, @showResultModal)
    @state =
      showBoard: false
      showRoom: true
      showResult: false

  createBoard: ->
    @setState {
      showBoard: false
      showRoom: false
    }
    socket.on 'join', (name) =>
      @setState {
        showBoard: true
        showRoom: false
        roomId: name
      }
  joinBoard: ->
    @setState {
      showBoard: false
      showRoom: false
    }
    socket.on 'join', (name) =>
      @setState {
        showBoard: true
        showRoom: false
        roomId: name
      }
  showResultModal: ->
    @setState showResult: true
  hideResultModal: ->
    @setState showResult: false
