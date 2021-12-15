require_relative '../config/environment'

class Game 

    attr_accessor :board, :player_1, :player_2, :current_player

    WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
    ]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
        @current_player = @player_1
    end


    def current_player
        turn_count % 2 == 0 ? current_player = @player_2 : current_player = @player_1
    end

    def turn_count
        @board.cells.collect {|e| e == "X" || e == "O"}.count
    end
    

    def won?
        WIN_COMBINATIONS.detect do |winning_combo|
          position_1 = @board.cells[winning_combo[0]]
          position_2 = @board.cells[winning_combo[1]]
          position_3 = @board.cells[winning_combo[2]]
            if position_1 == "X" && position_2 == "X" && position_3 == "X"
                return winning_combo
            elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
                return winning_combo
            else
                 false
             end
        end
    end

    def full?
        if @board.cells.any? {|i| i == nil || i == " "}
          return false
        else
          return true
        end
    end

    def draw?
        if full? == true && !won?
          return true
        else
          return false
        end
    end

    def over?
        if draw? || full? || won?
          return true
        else
          return false
        end
    end

    def winner
        if won?
          return @board.cells[won?[0]]
        else
          nil
         end
    end

    def swap_player
      @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
    end

    def turn
      puts "#{@player_1}"
      puts "#{@player_2}" 
      puts "#{@current_player}"
      
      num = @current_player.move(@board)
      if @board.valid_move?(num)
      @board.update(num, @current_player) 
      @board.display
      swap_player
      puts "#{@current_player.token}'s turn!"
      else
        puts "Square must be unoccupied."
        turn
      end
      
    end

    def play
      @board.display
      puts "#{@player_1}"
      puts "#{@player_2}"  
        while !won? && !draw? && !over?
          turn
        end
        if winner == "X"
          puts "Congratulations X!"
        elsif winner == "O"
          puts "Congratulations O!"
        elsif draw?
          puts "Cat's Game!"
        end
    end

    def cli_player_choices
      input = gets.chomp

      if input == "2"
      nil
      elsif input == "1"
      human_vs_comp
      elsif input == "0"
      @player_1 = Players::Computer.new("X") 
      @player_2 = Players::Computer.new("O") 
      else
        puts "Please enter valid input."
        cli_player_choices
      end
    end

    def human_vs_comp
      puts "Enter 'x' to play as x (first), and 'o' to play o (second)"
      input = gets.chomp

      if input == "x" || input == "X"
      @player_2 = Players::Computer.new("O")
      elsif input == "o" || input == "O"
      @player_1 = Players::Computer.new("X")
      else
      puts "Please enter a valid input."
      human_vs_comp
      end
    end

 end