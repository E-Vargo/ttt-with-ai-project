require_relative '../config/environment'
class Board

    attr_accessor :cells
    attr_reader :input

    def initialize
        reset!
    end

    def input=(input)
        @input = input.to_i - 1
    end

    def reset!
        self.cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display 
        puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
        puts "------------"
        puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
        puts "------------"
        puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    end

    def position(input)
        @cells[input.to_i - 1]
    end

    def full?
        @cells.any? {|i| i == " "} ? false : true
    end

    def turn_count
        count = @cells.find_all {|i| i != " "}
        count.count
    end

    def taken?(input)
        position(input) == " " ? false : true
    end

    def valid_move?(input)
        i = input.to_i
        i >= 1 && i <= 9 && taken?(i) == false ? true : false
    end

    def update(input, player)
       if valid_move?(input)
        @cells[input.to_i - 1] = player.token
       end
    end

end