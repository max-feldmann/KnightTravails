require_relative "00_tree_node.rb"

class KnightPathFinder

    VALID_MOVES = [[-2,1], [-2,-1], [-1,-2], [1,-2],
                    [2,-1], [2,1], [-1,2], [1,2]]
                    #=> add all those to a position in form of [x,y] to get possible moves of the knight

    attr_reader :current_position

    def initialize(starting_position)
        @current_position = starting_position
        @considered_moves = [starting_position] #=> Initialized w/ starting pos.
    end

    def valid_moves(pos) #=> Returns 2D-Array of valid Moves e.g. [[3,3], ...]
        potentials = []

        VALID_MOVES.each do |move| # go through predefined moves and add them to the position.
            possible_move = [0,0]
            possible_move[0] = pos[0] + move[0]
            possible_move[1] = pos[1] + move[1]

            unless possible_move.any? {|val| val > 7} # Make sure move is on the chess board (8x8)
                potentials << possible_move
            end

        end

        potentials
    end

    def new_move_positions(pos) #=> Returns 2D-Array of possible next moves, without such that have already been considered
        new_moves = []
        potential_moves = valid_moves(pos)
        
        #> Get potential moves, go through them
        #> If they have not yet been considered, add them to new_moves and add to "considered"

        potential_moves.each do |move| 
            if !@considered_moves.include?(move)
                new_moves << move 
                @considered_moves << move
            end
        end
        
        new_moves
    end

    def find_path(destination) #=> Return 2D-Array of Positions that leads to Destination
        
    end
end






# Playing Around with Polytree

#poly = PolyTreeNode.new("hi")
#poly2 = PolyTreeNode.new("HOi!")
#poly3 =PolyTreeNode.new("Sers")
#
#poly.parent = poly2
#poly2.add_child(poly3)
#p poly2
#poly2.remove_child(poly3)
#p poly2