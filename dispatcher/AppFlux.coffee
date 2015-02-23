Flux = require('flummox').Flux

GameActions = require('../actions/GameActions.coffee')

class AppFlux extends Flux
  constructor: ->
    super
    @createActions('game', GameActions)
    # @createStore('todo', TodoStore, @)

module.exports = AppFlux
