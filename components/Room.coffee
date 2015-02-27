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
    h4 Join
      .row
        .col-md-2
          form(onSubmit=onJoinForm)
            input.form-control(type="text" value=roomId onChange=handleRoomId)
            input.btn.btn-default(type="submit" value="Join")
    """)(_.assign(@, @props, @state))

  handleRoomId: (e) =>
    @setState roomId: e.target.value

  onJoinForm: (e) =>
    e.preventDefault()
    if @state.roomId
      socket.emit("join", @state.roomId)
      @props.flux.getActions("panel").moveToBoard()
