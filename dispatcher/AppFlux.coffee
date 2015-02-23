Flux = require('flummox').Flux

GameActions = require('../actions/GameActions.coffee')
BoardStore = require('../stores/BoardStore.coffee')

class AppFlux extends Flux
  constructor: ->
    super
    @createActions('game', GameActions)
    @createStore('board', BoardStore, @)

module.exports = AppFlux
