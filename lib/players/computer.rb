require_relative '../../config/environment.rb'

class Players 

    class Computer < Player 
        def move(board)
          if board.cells.all? {|c| c == " "}
          sleep(1)
          "5"
          
        else
          sleep(1)
          result = board.cells.find_index {|i| i == " "}
          (result + 1).to_s
          
        end
        end
    end

end