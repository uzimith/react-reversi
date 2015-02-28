window.socket = new RocketIO(channel: channel).connect()

React = require('react')
jade = require('react-jade')
_ = require('lodash')
Application = require('./components/Application.coffee')
AppFlux = require('./dispatcher/AppFlux.coffee')

flux = new AppFlux

require('./socket.coffee')(flux)

flux.getActions("panel").joinBoard(channel) if channel

React.render(React.createFactory(Application)(flux: flux), document.getElementById("container"))
