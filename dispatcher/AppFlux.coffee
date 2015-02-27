Flux = require('flummox').Flux

GameActions = require('../actions/GameActions.coffee')
PanelActions = require('../actions/PanelActions.coffee')
BoardStore = require('../stores/BoardStore.coffee')
PanelStore = require('../stores/PanelStore.coffee')

class AppFlux extends Flux
  constructor: ->
    super
    @createActions('game', GameActions)
    @createStore('board', BoardStore, @)
    @createActions('panel', PanelActions)
    @createStore('panel', PanelStore, @)

module.exports = AppFlux
