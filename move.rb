class Move
  require_relative "adjacent_space"

  attr_reader :adjacent_spaces, :row, :col, :player

  def initialize(col:, board:, player:, game:)
    @col = col
    @board = board
    @player = player
    @game = game

    place_piece
  end

  def place_piece
    @row = @board.open_space(@col)
    if @player.name == "player1"
      @board.spaces[@row][@col] = "1"
    else
      @board.spaces[@row][@col] = "2"
    end
    @board.render
  end

  def winning_move?
    check_pieces_in_a_row
  end

  private
    def check_pieces_in_a_row
      adjacent_spaces.each do |adj_space|
        if adj_space.val == move_val
          if @game.num_to_win == 2
            return true #winner
          else
            return check_along_direction(adj_space, 2)
          end
        end
      end

      false #no adjacents found, no winner
    end

    def check_along_direction(space, in_a_row, checked_opp: false)
      next_space = increment_space_along_direction(space)

      if @board.contains?(row: next_space.row, col: next_space.col)
        next_space.val = @board.spaces[next_space.row][next_space.col]
        if next_space.val == move_val
          in_a_row += 1
          if enough_to_win?(in_a_row)
            return true
          else
            check_along_direction(next_space, in_a_row, checked_opp: false)
          end
        elsif checked_opp == false
          check_space_opp_of_orig(space, in_a_row)
        else
          return false
        end
      else
        check_space_opp_of_orig(space, in_a_row)
      end
    end

    def check_space_opp_of_orig(space, in_a_row)
      opp_space = find_space_opposite_of_original(space)
      check_along_direction(opp_space, in_a_row, checked_opp: true)
    end

    def find_space_opposite_of_original(space)
      opp_space = space.clone
      opp_space.dir_r = -space.dir_r #reverse directions
      opp_space.dir_c = -space.dir_c
      opp_space.row = @row + opp_space.dir_r #set space to adj to orig in opp direction
      opp_space.col = @col + opp_space.dir_c
      opp_space
    end

    def enough_to_win?(val)
      @game.num_to_win == val
    end

    def increment_space_along_direction(space)
      new_space = space.clone
      new_space.row = space.row + space.dir_r
      new_space.col = space.col + space.dir_c
      new_space
    end

    def adjacent_spaces
      @adjacent_spaces = []
      start_row = @board.valid_row?(@row - 1) ? @row - 1 : @row
      start_col = @board.valid_col?(@col - 1) ? @col - 1 : @col
      end_row = @board.valid_row?(@row + 1) ? @row + 1 : @row
      end_col = @board.valid_col?(@col + 1) ? @col + 1 : @col

      (start_row..end_row).each do |r|
        (start_col..end_col).each do |c|
          unless r == @row && c == @col
            adj = AdjacentSpace.new(r, c, self)
            adj.val = @board.spaces[r][c]
            @adjacent_spaces << adj
          end
        end
      end
      @adjacent_spaces
    end

    def move_val
      @board.spaces[@row][@col]
    end

end
