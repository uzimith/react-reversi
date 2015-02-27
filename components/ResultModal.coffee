React = require('react')
jade = require('react-jade')
_ = require('lodash')

module.exports =
class ResultModal extends React.Component
  render: =>
    cx = React.addons.classSet
    classes = cx {
      in: @props.showResult
      show: @props.showResult
    }
    jade.compile("""
      .modal.fade(class=classes)
        .modal-dialog
          .modal-content
            .modal-header
              button.close(onClick=onClick)
                span &times;
              h4.modal-title Result
            .modal-body
              p Win!!!
            .modal-footer
    """)(_.assign(@, @props, @state))

  onClick: =>
    @props.flux.getActions("panel").hideResult()
