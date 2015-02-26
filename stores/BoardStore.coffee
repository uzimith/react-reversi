React = require('react')
Store = require('flummox').Store
_ = require('lodash')
window._ = require('lodash')


module.exports =
class BoardStore extends Store
  constructor: (flux) ->
    super
    gameActions = flux.getActionIds('game')
    @register(gameActions.addPiece, @handleNewPiece)
    @register(gameActions.startGame, @handleNewGame)
    @num = 8
    @state =
      player: 0,
      player_trait: {1: '◯', 2: '●'}, # now don't use this
      scores: {}
    @state.grids = _.map [0...@num], (row) =>
      _.map [0...@num], (col) =>
        {row: row, col: col, next: false, piece: null}

  handleNewGame: (player) ->
    @setState player: player
    @state.grids = _.map [0...@num], (row) =>
      _.map [0...@num], (col) =>
        piece = null
        if (row is 3 and col is 3) or (row is 4 and col is 4)
          piece = {player: 1}
        if (row is 3 and col is 4) or (row is 4 and col is 3)
          piece = {player: 2}
        {row: row, col: col, next: false, piece: piece}
    @calculateScores()
    @searchNextPutableGrid(player)

  handleNewPiece: (grid) ->
    # add piece
    grids = @state.grids
    grids[grid.row][grid.col] = grid

    # turn the other player's piece
    arounds = _.flatten( [i,j] for i in [-1..1] for j in [-1..1])

    _.each arounds, (d) =>
      row = grid.row
      col = grid.col
      dx = d[0]; dy = d[1]
      found = false
      for i in [0...@num]
        row += dx
        col += dy
        break unless (0 <= row and row < @num) and (0 <= col and col < @num)
        break if !grids[row][col].piece
        found = true if grids[row][col].piece.player == @state.player
      if found
        for j in [0..i]
          grids[grid.row + dx*j][grid.col + dy*j].piece.player = @state.player

    # update
    @setState grids: grids
    @calculateScores()
    next_player = @changeToNextPlayer()
    @searchNextPutableGrid(next_player)

  handleNextTurn: ->
    # change to next player

    # search next putable grid

  calculateScores: ->
    scores = {}
    for rows in @state.grids
      for grid in rows
        if grid.piece
          player = grid.piece.player
          scores[player] = 0 unless scores[player]
          scores[player]++
    @setState scores: scores

  changeToNextPlayer: ->
    if @state.player == 1
      next_player = 2
    if @state.player == 2
      next_player = 1
    @setState player: next_player
    return next_player

  searchNextPutableGrid: (player)->
    grids = @state.grids
    arounds = _.flatten( [i,j] for i in [-1..1] for j in [-1..1])

    for rows in grids
      for grid in rows
        grid.next = _.any(_.map(arounds, (a) => @searchDirection(player, grid, a[0], a[1])))
    @setState grids: grids

  # private

  searchDirection: (player, grid, dx, dy) =>
    # check start grid state
    return false if grid.piece

    # check next grid state
    row = grid.row + dx
    col = grid.col + dy
    return false unless (0 <= row and row < @num) and (0 <= col and col < @num)
    return false if !@state.grids[row][col].piece or @state.grids[row][col].piece.player == player

    # search player piece
    for i in [0...@num - 2]
      row += dx
      col += dy
      return false unless (0 <= row and row < @num) and (0 <= col and col < @num)
      return false if !@state.grids[row][col].piece
      return true if @state.grids[row][col].piece and @state.grids[row][col].piece.player == player
    retun false
