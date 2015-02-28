React = require('react')
Store = require('flummox').Store
_ = require('lodash')

module.exports =
class BoardStore extends Store
  constructor: (flux) ->
    super
    gameActions = flux.getActionIds('game')
    @register(gameActions.addPiece, @handleNewPiece)
    @register(gameActions.startGame, @handleNewGame)
    @register(gameActions.endGame, @handleEndGame)
    @register(gameActions.giveupGame, @handleGiveup)
    @num = 8
    @state =
      player: 0
      scores: {}
      winner: 0
      play: false
      end: false
    @state.grids = _.map [0...@num], (row) =>
      _.map [0...@num], (col) =>
        {row: row, col: col, next: false, piece: null}

  handleNewGame: (player) ->
    grids = _.map [0...@num], (row) =>
      _.map [0...@num], (col) =>
        piece = null
        if (row is 3 and col is 3) or (row is 4 and col is 4)
          piece = {player: 1}
        if (row is 3 and col is 4) or (row is 4 and col is 3)
          piece = {player: 2}
        {row: row, col: col, next: true, piece: piece}
    # update
    scores = @calculateScores()
    [grids, found] = @searchNextPutableGrid(grids, player)
    @setState
      grids: grids
      scores: scores
      player: player
      winner: 0
      play: true
      end: false

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
        if grids[row][col].piece.player == @state.player
          found = true
          break
      if found
        for j in [0..i]
          grids[grid.row + dx*j][grid.col + dy*j].piece.player = @state.player

    # update
    scores = @calculateScores()
    end = false
    next_player = @fetchNextPlayer(@state.player)
    [grids, found] = @searchNextPutableGrid(grids, next_player)
    unless found
      next_player = @fetchNextPlayer(next_player)
      [grids, found] = @searchNextPutableGrid(grids, next_player)
      unless found
        end = true
    console.log(next_player)
    @setState
      grids: grids
      player: next_player
      scores: scores
      end: end

  handleEndGame: ->
    grids = @state.grids
    for rows in grids
      for grid in rows
        grid.next = false
    winner = _.max _.keys(@state.scores), ((key) => @state.scores[key])

    # draw
    winner = 0 if @state.scores[0] is @state.scores[1]

    @setState
      grids: grids
      winner: winner
      play: false

  handleGiveup: (player)->
    grids = @state.grids
    for rows in grids
      for grid in rows
        grid.next = false
    winner = @fetchOpponent(player)

    @setState
      grids: grids
      winner: winner
      play: false

  # private

  calculateScores: ->
    scores = {}
    for rows in @state.grids
      for grid in rows
        if grid.piece
          player = grid.piece.player
          scores[player] = 0 unless scores[player]
          scores[player]++
    return scores

  fetchNextPlayer: (player) ->
    if player == 1
      return 2
    if player == 2
      return 1

  fetchOpponent: (player) ->
    if player == 1
      return 2
    if player == 2
      return 1

  searchNextPutableGrid: (grids, player)->
    arounds = _.flatten( [i,j] for i in [-1..1] for j in [-1..1])
    found = false

    for rows in grids
      for grid in rows
        grid.next = _.any(_.map(arounds, (a) => @searchDirection(player, grids, grid, a[0], a[1])))
        found = true if grid.next
    return [grids, found]

  searchDirection: (player, grids, grid, dx, dy) =>
    # check start grid state
    return false if grid.piece

    # check next grid state
    row = grid.row + dx
    col = grid.col + dy
    return false unless (0 <= row and row < @num) and (0 <= col and col < @num)
    return false if !grids[row][col].piece or grids[row][col].piece.player == player

    # search player piece
    for i in [0...@num - 2]
      row += dx
      col += dy
      return false unless (0 <= row and row < @num) and (0 <= col and col < @num)
      return false if !grids[row][col].piece
      return true if grids[row][col].piece and grids[row][col].piece.player == player
    return false
