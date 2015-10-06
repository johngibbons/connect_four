require_relative "game"

game = Game.new
game.generate_board
game.set_num_to_win
game.play

