require_relative 'env'

data = (Path.dir/'board.json').load
board = Chess::Board.alpha(data)

puts board

# puts Chess::Board.omega(board)
#                  .down(:piece)
#                  .unwrap(:piece)
#                  .summarize([:color], count: count())

# puts Relation.alpha(data)
#              .unwrap(:piece)
#              .summarize([:color], count: count())
