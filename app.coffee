window.React = require('react')
jade = require('react-jade')
_ = require('lodash')
Application = require('./components/Application.coffee')
AppFlux = require('./dispatcher/AppFlux.coffee')

flux = new AppFlux
React.render(React.createFactory(Application)(flux: flux), document.getElementById("container"))
