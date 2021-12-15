require_relative '../config/environment'

class Player 

    attr_reader :token

    def initialize(token)
        @token = token
    end

end