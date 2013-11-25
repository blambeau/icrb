require_relative 'env'

data = (Path.dir/'board.json').load
board = Chess::Board.alpha(data)
puts board.to_yaml