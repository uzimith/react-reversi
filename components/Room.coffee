React = require('react')
jade = require('react-jade')
_ = require('lodash')

module.exports =
class Room extends React.Component
  constructor: ->
    @state = {
      roomId: ""
    }
  render: =>
    jade.compile("""
    h3 Room
      .row
        .col-md-2
          hr
          form(onSubmit=onCreateForm)
            input.btn.btn-default(type="submit" value="Create")
      .row
        .col-md-2
          hr
          form(onSubmit=onJoinForm)
            input.form-control(type="text" value=roomId onChange=handleRoomId)
            input.btn.btn-default(type="submit" value="Join")
    """)(_.assign(@, @props, @state))

  handleRoomId: (e) =>
    @setState roomId: e.target.value

  onCreateForm: (e) =>
    e.preventDefault()
    socket.push("create", null)
    @props.flux.getActions("panel").createBoard()

  onJoinForm: (e) =>
    e.preventDefault()
    if @state.roomId
      socket.push("join", @state.roomId)
      @props.flux.getActions("panel").joinBoard()
