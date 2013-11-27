require_relative 'env'

data = (Path.dir/'board.json').load

# Let load the board from the data there.
# Everything is deserialized correctly
board = Chess::Board.dress(data)

# This is a beautiful chess board abstraction:
puts board

# Let undress the abstraction and extract its information content
rel = Chess::Board.undress(board)

# This is a pure data relation
puts rel

# You can query it easily. How many pieces per color?
puts rel.down(:piece).unwrap(:piece).summarize([:color], count: count())

# You can even serialize that content properly
puts rel.to_json

# Let dress the abstraction again
board2 = Chess::Board.dress(rel)

# This is the same board, of course
puts board == board2
